# Stage 1: Build binary
FROM golang:1.22 AS buildstage
WORKDIR /app
COPY . .
RUN go build -o frontend ./...

# Stage 2: Runtime
FROM gcr.io/distroless/base-debian12 AS runtime
WORKDIR /app
COPY --from=buildstage /app/frontend .
EXPOSE 8080
CMD ["./frontend"]
