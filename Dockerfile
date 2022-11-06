FROM golang:alpine as builder

WORKDIR /app 

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o k8s-example-app .

FROM scratch

WORKDIR /app

COPY --from=builder /app/k8s-example-app /usr/bin/

ENTRYPOINT ["k8s-example-app"]