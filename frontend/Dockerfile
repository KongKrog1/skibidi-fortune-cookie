# Multi-stage build for smaller image
FROM golang:1.16 AS builder

WORKDIR /app
COPY . .
RUN go build -o frontend .

EXPOSE 8080
CMD ["./frontend"]
