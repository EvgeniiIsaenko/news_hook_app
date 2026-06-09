// file for all contacts regarding this organization and the development team for this app

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:namer_app/utilities.dart';
import 'package:url_launcher/link.dart';
import 'package:http/http.dart' as http;

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late Future<WeatherData> _weatherFuture;

  void initState() {
    super.initState();
    _weatherFuture = fetchWeather(http.Client());
  }

  final universalTextStyle = const TextStyle(color: Colors.white, fontSize: 20);
  final String phoneNumber = '+7(xxx)xxx-xx-xx'; // TODO: fill these
  final String address = "Город Владивосток";

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 15.0),
          color: Color.fromRGBO(33, 37, 41, 1),
          child: Text('Контакты News Hook:',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors
                      .white)), // TODO: check if the scaling is off on ALL devices
        ),
        Divider(thickness: 3, height: 3, color: Colors.grey),
        Container(
          padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Телефон: $phoneNumber',
                style: universalTextStyle,
              ),
              Text(
                'Адрес: $address',
                style: universalTextStyle,
              ),
              Link(
                uri: Uri.parse(
                    'http://${getLocalHost()}:5150'), // TODO: change to actual website
                builder: (context, followLink) {
                  return RichText(
                    text: TextSpan(
                      text: 'Веб-сайт News Hook.',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 20),
                      recognizer: TapGestureRecognizer()..onTap = followLink,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 15.0),
          color: Color.fromRGBO(33, 37, 41, 1),
          child: Text('Погода во Владивостоке:',
              style: TextStyle(fontSize: 25, color: Colors.white)),
        ),
        Divider(thickness: 3, height: 3, color: Colors.grey),
        Container(
          padding: EdgeInsets.all(15.0),
          child: FutureBuilder<WeatherData>(
            future: _weatherFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text(
                  'Ошибка загрузки погоды: ${snapshot.error}',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                );
              } else if (snapshot.hasData) {
                final weather = snapshot.data!;
                return Row(
                  children: [
                    Image.network(
                      'https://openweathermap.org/img/w/${weather.iconCode}.png',
                      width: 60,
                      height: 60,
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${weather.tempCelsius.toStringAsFixed(0)}°C',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          weather.description,
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
        Divider(thickness: 3, height: 3, color: Colors.grey),
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 15.0),
          color: Color.fromRGBO(33, 37, 41, 1),
          child: Text('Контакты разработчиков:',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors
                      .white)), // TODO: check if the scaling is off on ALL devices
        ),
        Divider(thickness: 3, height: 3, color: Colors.grey),
        Container(
          padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Link(
                uri:
                    Uri.parse('https://github.com/'), // TODO: add git repo link
                builder: (context, followLink) {
                  return Row(
                    children: [
                      FaIcon(FontAwesomeIcons.github),
                      Text(' '),
                      RichText(
                        text: TextSpan(
                          text: 'GitHub репозиторий',
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 20),
                          recognizer: TapGestureRecognizer()
                            ..onTap = followLink,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
