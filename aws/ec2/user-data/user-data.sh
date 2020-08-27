#!/bin/bash

# Log the process

set -x
exec > >(tee /var/log/user-data.log|logger -t user-data) 2>&1
date '+%Y-%m-%d %H:%M:%S'

# Update the system

yum check-update
yum -y update

# Install node.js, npm, and pm2

sudo -i -u ec2-user bash << 'EOF'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
source ~/.nvm/nvm.sh
nvm install ${node_version}
npm install -g pm2
EOF

ln -s /home/ec2-user/.nvm/versions/node/${node_version}/bin/pm2 /usr/bin/pm2
ln -s /home/ec2-user/.nvm/versions/node/${node_version}/bin/npm /usr/bin/npm
ln -s /home/ec2-user/.nvm/versions/node/${node_version}/bin/node /usr/bin/node

# Create Hello.js
# CREDIT: https://github.com/GoogleCloudPlatform/container-engine-samples/blob/master/hellonode/server.js

mkdir -p /home/ec2-user/app
cat > /home/ec2-user/app/hello.js << 'EOF'
const http = require('http');
const os = require('os');
const port = process.env.PORT || ${port};

var handleRequest = function(request, response) {
  console.log('Received request for URL: ' + request.url);
  response.writeHead(200);
  response.end('Hello, World!\nHostname: ' + os.hostname() + '\n');
};

var www = http.createServer(handleRequest);
www.listen(port, () => {
  console.log('server listening on port ' + port + '\n');
});
EOF
chown -R ec2-user:ec2-user /home/ec2-user/app

# Run the application

runuser -l ec2-user -c 'pm2 start /home/ec2-user/app/hello.js'
