# --- Build Stage ---

FROM golang:1.14.9-alpine3.12 as build

RUN apk add --no-cache make

# Copy mod files.
WORKDIR /src
COPY go.mod go.sum ./

# Install modules.
RUN go mod tidy && \
    go mod vendor

# Copy everything including .git since we want to embed the
# commit sha to the app
COPY main.go Makefile ./

# Build
#RUN go build -o env-go
RUN make

# --- Final Stage ---

FROM alpine:3.12

# Add a user.
# See https://stackoverflow.com/a/55757473/12429735
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/app" \
    --shell "/sbin/nologin" \
    --no-create-home \
    "golang"

# Install tini.
RUN apk add --no-cache tini

# Copy the binary over.
WORKDIR /app
COPY --from=build --chown=golang:golang /src/env-go ./

# Run it as a non-privileged user.
USER golang

# Run Node.
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/app/env-go"]
