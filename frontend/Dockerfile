# Stage 1: Build
FROM golang:1.22 AS builder
WORKDIR /app
COPY . .
RUN go build -o frontend ./...

# Stage 2: Runtime
WORKDIR /app
COPY --from=builder /app/frontend .
EXPOSE 8080
CMD ["./frontend"]
