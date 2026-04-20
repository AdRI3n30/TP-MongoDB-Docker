FROM mongo:8.2.7
USER mongodb
COPY ./dbfiles /docker-entrypoint-initdb.d
EXPOSE 27017
