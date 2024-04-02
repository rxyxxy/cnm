FROM ubuntu:22.04
RUN mkdir app && apt update && apt install wget unzip curl nginx -y
WORKDIR /app
ADD main.sh .
RUN chmod 777 main.sh
EXPOSE 80
CMD ["./main.sh"]

