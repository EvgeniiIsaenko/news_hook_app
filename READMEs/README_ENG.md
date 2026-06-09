# news_hook_app
An events/news website with an application that allows to look through the site's contents.

Made as part of an assignment in VVSU, written in dotnet and flutter.

Stack:
    - PSQL,
    - Flutter,
    - ASP.Net (+ ef for db)

## How to launch:
### Create DB:
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

## In main directory:
### Site and backend
```bash
dotnet restore ./news_hook_web
# if you dont have dotnet-ef installed
dotnet tool install --global dotnet-ef
dotnet run --project ./news_hook_web
```

### Flutter
```bash
cd ./news_hook_mobile
# you might need to clean the build files
flutter clean
flutter run
```
