# Usa la imagen base de .NET SDK
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

WORKDIR /app

# Copia el archivo .csproj y restaura las dependencias
COPY *.csproj ./
RUN dotnet restore

# Copia todo el resto del código
COPY . ./

# Publica la aplicación en modo Release
RUN dotnet publish -c Release -o /out

# Usa la imagen base de .NET Runtime para ejecutar la aplicación
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime

WORKDIR /app

# Copia la aplicación publicada
COPY --from=build /out .

# Configura el punto de entrada
ENTRYPOINT ["dotnet", "CachuelosSA-Api.dll"]
