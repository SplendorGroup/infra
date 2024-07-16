export DOMAIN="*.gfrancodev.com"
openssl req -new -key ./key.pem -out ./server.csr -subj "/CN=$DOMAIN"