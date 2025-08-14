# Multi-stage build
FROM golang:1.22 AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o backend .

WORKDIR /app
COPY --from=builder /app/backend .

EXPOSE 9000
CMD ["./backend"]
