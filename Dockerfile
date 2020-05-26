##################################
# STEP 1 build executable binary #
##################################
FROM golang:alpine AS builder

WORKDIR /go/src/app
COPY hello.go .

#RUN go build hello.go
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /go/bin/hello

CMD ["./hello"]

##################################
# STEP 2 build a small image     #
##################################
FROM scratch

# Copy our static executable.
COPY --from=builder /go/bin/hello /go/bin/hello

# Run the hello binary.
ENTRYPOINT ["/go/bin/hello"]
