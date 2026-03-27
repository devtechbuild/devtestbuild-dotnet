# Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

COPY *.csproj ./
RUN dotnet restore

COPY . .

#  IMPORTANT: specify project file
RUN dotnet publish DevTestBuild-01.csproj -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 80
ENTRYPOINT ["dotnet", "DevTestBuild-01.dll"]
