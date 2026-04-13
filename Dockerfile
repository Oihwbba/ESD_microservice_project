FROM ubuntu:22.04
COPY . /app
WORKDIR /app
RUN apt-get update && apt-get install -y docker.io docker-compose
COPY --from=docker/compose:latest /usr/local/bin/docker-compose /usr/local/bin/docker-compose
CMD ["docker-compose", "up", "--build", "-d"]
