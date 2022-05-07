#Define imagem base para compilar o APP e define o nome dele como "build"
FROM mcr.microsoft.com/dotnet/sdk:5.0-alpine3.15 AS build
#Cria o espaço de trabalho do aplicativo sem estar compilado
WORKDIR /source
#Copia arquivo dentro do WORKDIR
COPY . ./
#Executa comando para restaurar as dependências
RUN dotnet restore
#Cria o arquivo do app compilado
RUN dotnet publish -c release -o /app/app_compilado

#Imagem base para execução do APP
FROM mcr.microsoft.com/dotnet/aspnet:5.0-alpine3.15
#Define o Espaço de trabalho para execução do APP
WORKDIR /app
#Copia os arquivos do diretório de build para espaço de trabalho atual
COPY --from=build /app/app_compilado .
#Executa o aplicativo compilado
ENTRYPOINT ["dotnet", "ConversaoPeso.Web.dll"]