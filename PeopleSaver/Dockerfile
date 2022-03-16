FROM mcr.microsoft.com/dotnet/sdk:6.0 as base
WORKDIR /code

COPY . .
RUN dotnet publish -c Release -o /output
RUN rm -f /output/appsettings.*

FROM mcr.microsoft.com/dotnet/aspnet:6.0 as final
WORKDIR /app

COPY --from=base /output .
EXPOSE 443
EXPOSE 80

CMD ["dotnet", "run", "PeopleSave.dll"]