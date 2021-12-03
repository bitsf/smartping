FROM scratch
WORKDIR /
ADD conf conf
ADD db/database-base.db db/
ADD html html
COPY smartping ./
ENTRYPOINT ["/smartping"]
EXPOSE 8899
