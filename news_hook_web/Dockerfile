FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source

ENV DOTNET_EnableWriteXorExecute=0

COPY ["news_hook_web/News_Hook.csproj", "news_hook_web/"]
RUN dotnet restore "news_hook_web/"

COPY ./news_hook_web .
WORKDIR "/source/news_hook_web"
RUN dotnet build "News_Hook.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "News_Hook.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
EXPOSE 80
EXPOSE 443
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "News_Hook.dll"]