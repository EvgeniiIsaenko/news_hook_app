// utility functions, structs (classes of specific objects) and variables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'dart:convert';
import 'dart:async';

// temporary measure for virtual emulators, only takes 10.0.2.2 as localhost
//https://stackoverflow.com/questions/55785581/socketexception-os-error-connection-refused-errno-111-in-flutter-using-djan
String getLocalHost() {
  return '10.0.2.2';
}

dynamic displayImage(dynamic item) {
  // displays image for any item with imgPath property
  if (item.imgPath != 'null') {
    print('displayed an image');
    return Image.network(
      'http://${getLocalHost()}:5150/media/${item.imgPath.replaceAll('\\', '/').split('/')[2]}',
      fit: BoxFit.fitHeight,
    ); // displays an image
  } else {
    print('image fetch failure');
    return SizedBox.shrink();
  }
}

Future<List<dynamic>> fetchData(http.Client client, String itemInApi) async {
  // fetches json and starts an isolated parsing of the events
  final response = await http.get(Uri.parse(
      'http://${getLocalHost()}:5150/Api/$itemInApi')); // TODO: тестовый джей сон поменять на нормальный

  switch (itemInApi) {
    case 'Events':
      return compute(parseEvents, response.body);
    case 'News':
      return compute(parseNews, response.body);
  }

  throw "itemInApi didn't match any of the types for fetching data";
}

List<Event> parseEvents(String responseBody) {
  // decodes the json and casts into a map of strings
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed
      .map<Event>((json) => Event.fromJson(json))
      .toList(); // maps the events and then turns them into lists (very complicated stuff, surprised this works)
}

List<NewsArticle> parseNews(String responseBody) {
  // decodes the json and casts into a map of strings
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed
      .map<NewsArticle>((json) => NewsArticle.fromJson(json))
      .toList(); // maps the events and then turns them into lists (very complicated stuff, surprised this works)
}

class Event {
  // struct of an <Event> type objects
  final String id;
  final String name;
  final String description;
  final String dateTime;
  final String text;
  final String imgPath;

  const Event({
    required this.id,
    required this.name,
    required this.description,
    required this.dateTime,
    required this.text,
    required this.imgPath,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    // fetches json's variables and maps them to the <Event> object
    return Event(
      // also possible to write with a newer implementation in .dart (pattern matching for json)
      id: json['id']
          as String, // https://stackoverflow.com/questions/77554946/could-someone-explain-how-this-code-struct-in-dart-and-fetching-values-from-jso
      name: json['name'] as String, // this is the code + an explanation
      description: json['description'] as String,
      dateTime: json['dateTime'] as String,
      text: json['text'] as String,
      imgPath: json['imgPath'] as String,
    );
  }
}

class NewsArticle {
  final String id;
  final String name;
  final String description;
  final String dateTime;
  final String imgPath;

  const NewsArticle({
    required this.id,
    required this.name,
    required this.description,
    required this.dateTime,
    required this.imgPath,
  });
// TODO: change to whatever data I am pulling from the JSON
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    // fetches json's variables and maps them to the <Event> object
    return NewsArticle(
      // also possible to write with a newer implementation in .dart (pattern matching for json)
      id: json['id']
          as String, // https://stackoverflow.com/questions/77554946/could-someone-explain-how-this-code-struct-in-dart-and-fetching-values-from-jso
      name: json['name'] as String, // this is the code + an explanation
      description: json['description'] as String,
      dateTime: json['dateTime'] as String,
      imgPath: json['imgPath'] as String,
    );
  }
}

class WeatherData {
  // for openweather api for lab 6
  final double tempCelsius;
  final String description;
  final String iconCode;

  WeatherData({
    required this.tempCelsius,
    required this.description,
    required this.iconCode,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final main = json['main'];
    final weather = json['weather'][0];
    return WeatherData(
      // have to call only in kelvins
      tempCelsius: (main['temp'] - 273.15).roundToDouble(),
      description: weather['description'],
      iconCode: weather['icon'],
    );
  }
}

Future<WeatherData> fetchWeather(http.Client client) async {
  final apiKey = 'd871da050430cd099832faf8c1dff38e';
  final city = 'Vladivostok';
  final language = 'ru';
  final url =
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&lang=$language'; //&lang=ru';

  final response = await client.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return WeatherData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Не удалось загрузить погоду: ${response.statusCode}');
  }
}
