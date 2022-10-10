FROM mcr.microsoft.com/dotnet/sdk:6.0 as builder
WORKDIR /code

COPY . .
RUN dotnet publish --configuration Release --output /publish

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app

COPY --from=builder /publish .
EXPOSE 80

CMD [ "dotnet", "WeatherForecast.dll" ]