FROM microsoft/aspnetcore:1.1

WORKDIR /app
COPY ./ /app

ENV ASPNETCORE_URLS http://*:5000
EXPOSE 5000

CMD ["dotnet", "JenkinsDockerDemo1.dll"]

