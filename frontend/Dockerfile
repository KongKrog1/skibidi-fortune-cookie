# Multi-stage build for smaller image
FROM golang:1.22 AS builder

WORKDIR /app
COPY . .
RUN go build -o frontend .

WORKDIR /app
COPY --from=builder /app/frontend . 
COPY --from=builder /app/static ./static  

EXPOSE 8080
CMD ["./frontend"]
