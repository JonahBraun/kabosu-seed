FROM golang:1.11-alpine

WORKDIR /app
ADD *.go ./
RUN go build -o main .


# Copy binary into a thinner container.
FROM alpine:latest

COPY --from=0 /app/main .
CMD ["./main"]
