# Stage 1: Build binary
FROM golang:1.22 AS buildstage
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o backend ./...

# Stage 2: Runtime
FROM gcr.io/distroless/base-debian12 AS runtime
WORKDIR /app
COPY --from=buildstage /app/backend .
EXPOSE 9000
CMD ["./backend"]
