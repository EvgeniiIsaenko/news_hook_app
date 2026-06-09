# news_hook_app
Сайт с мероприятиями/новостями и приложением, через которое можно просматривать ближайшие события.

Сделано в качестве задания для ВВГУ, написано на dotnet и flutter.

Стэк:
    - PSQL,
    - Flutter,
    - ASP.Net (+ ef для db)

## Запуск:
### Создайте базу:
```psql
CREATE DATABASE NewsHookDb;

\c NewsHookDb;

CREATE TABLE "Events" (
    "Id" uuid PRIMARY KEY,
    "Name" text NOT NULL,
    "Description" text NOT NULL,
    "Text" text NOT NULL,
    "DateTime" timestamp NOT NULL DEFAULT CURRENT_DATE,
    "ImgPath" text
);

CREATE TABLE "MediaLinks" (
    "Id" uuid PRIMARY KEY,
    "Name" text,
    "Url" text,
    "CreationTime" timestamp NOT NULL DEFAULT now()
);

CREATE TABLE "News" (
    "Id" uuid PRIMARY KEY,
    "PublicationTime" timestamp NOT NULL DEFAULT CURRENT_DATE,
    "Name" text,
    "ImgPath" text,
    "Description" text
);

CREATE TABLE "Users" (
    "Id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "Login" text,
    "Password" text
);
```

## В основной директории:
### Сайт и бэкэнд
```bash
dotnet restore ./news_hook_web
# если не установлен dotnet-ef
dotnet tool install --global dotnet-ef
dotnet run --project ./news_hook_web
```

### Flutter
Можно собрать как .apk, можно запустить эмулятор на компьютере и можно запустить просто как десктоп приложение.
При запуске/билде с телефона необходимо подключить по USB со включенным режимом разработчика.
Легче всего для теста включить эмулятор на ПК.
```bash
cd ./news_hook_mobile
# возможно необходимо почистить билд-файлы
flutter clean
flutter run
```
