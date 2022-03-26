FROM mcr.microsoft.com/dotnet/sdk:6.0 as base
WORKDIR /code

COPY . .
RUN dotnet publish --configuration Release -o /output

FROM mcr.microsoft.com/dotnet/aspnet:6.0 as final
WORKDIR /app

COPY --from=base /output .
RUN ls -l
EXPOSE 80
EXPOSE 443

CMD [ "dotnet", "PeopleSaver.dll" ]