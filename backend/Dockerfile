# Multi-stage build
FROM golang:1.22 AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o backend .

# Final runtime image
FROM gcr.io/distroless/base-debian12

WORKDIR /app
COPY --from=builder /app/backend .

EXPOSE 9000
CMD ["./backend"]
