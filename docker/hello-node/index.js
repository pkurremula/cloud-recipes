// CREDIT: https://github.com/GoogleCloudPlatform/container-engine-samples/blob/master/hellonode/server.js

const http = require('http');
const os = require('os');
const port = process.env.PORT || 8080;

var handleRequest = function(request, response) {
    console.log(`Received request for URL: ${request.url}`);
    response.writeHead(200);
    response.end(`Hello, World!\nHostname: ${os.hostname()}\n`);
};

var server = http.createServer(handleRequest);
server.listen(port, () => {
    console.log(`server listening on port ${port}`);
});
