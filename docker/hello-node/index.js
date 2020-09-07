// Based on https://github.com/GoogleCloudPlatform/container-engine-samples/blob/master/hellonode/server.js

const http = require('http');
const os = require('os');
const pino = require('pino');
const process = require('process');
const port = process.env.PORT || 8080;

// Logger
const logger = pino();

// Handle signals for a graceful exit

process.on('SIGINT', () => {
   logger.info('received SIGINT');
   shutdown();
});

process.on('SIGTERM', () => {
    logger.info('received SIGTERM');
    shutdown();
});

const shutdown = function() {
    server.close((err) => {
        if (err) {
            console.error(err);
            process.exit(1);
        }

        logger.info('http server closed');

        // Close other resources here.
        process.exit(0);
    });
}


// Handler

const handleRequest = function(request, response) {
    logger.info(`received request for URL: ${request.url} from ${request.connection.remoteAddress}`);
    response.writeHead(200);
    response.end(`Hello, World!\nServer: ${os.hostname()}\n`);
};

// Application server

const server = http.createServer(handleRequest);
server.listen(port, () => {
    logger.info(`server listening on port ${port}`);
});
