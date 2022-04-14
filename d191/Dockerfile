FROM postgres:latest

ENV POSTGRES_PASSWORD admin

COPY  --chown=postgres data/* /tmp/
COPY  --chown=postgres restore.sql /docker-entrypoint-initdb.d/
