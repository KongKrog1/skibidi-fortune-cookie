# Stage 1: Build
FROM golang:1.22 AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o backend .

# Stage 2: Runtime
WORKDIR /app
COPY --from=builder /app/backend /app/backend
EXPOSE 9000
CMD ["/app/backend"]
