# --- Build Stage ---

FROM node:14.9.0-alpine3.12 as build

# Copy package.json and related files.
WORKDIR /src
COPY package*.json ./

# Install packages.
RUN npm ci --production && npm cache clean --force

# Copy the source files.
COPY index.js ./

# --- Final Stage ---

FROM node:14.9.0-alpine3.12

# Copy the source files over.
WORKDIR /app
COPY --from=build --chown=node:node /src ./

# Install tini.
RUN apk add --no-cache tini

# Run it as a non-privileged user.
USER node

# Expose port.
EXPOSE 8080

# Run Node.
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["node", "index.js"]
