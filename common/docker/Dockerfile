FROM node:alpine

# Copy this file to the container
RUN mkdir /app
COPY index.js /app

# Expose port and run Node
EXPOSE 8080
CMD ["node", "/app/index.js"]
