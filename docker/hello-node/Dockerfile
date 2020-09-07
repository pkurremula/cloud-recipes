# --- Build Stage ---

FROM node:alpine as build

# Copy package.json and related files.
WORKDIR /app
COPY package*.json ./

# Install packages.
RUN npm ci --production && npm cache clean --force

# Copy the source files.
COPY index.js ./

# --- Final Stage ---

FROM node:alpine

WORKDIR /app
COPY --from=build --chown=node:node /app ./

# Install tini.
# The best way to handle system interrupts eg. SIGINT or SIGTEM is
# 1. Implement system signal handlers in JavaScript. See index.js.
# 2. If we don't have access to the source code, use tini and wrap node around it.
RUN apk update && \
    apk upgrade && \
    apk add --no-cache tini

# Run it as a non-privileged user.
USER node

# Expose port.
EXPOSE 8080

# Run Node.
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["node", "index.js"]
