FROM golang:1.22

WORKDIR /app
COPY . .
RUN go mod download && go build -o backend .

EXPOSE 9000
CMD ["./backend"]
