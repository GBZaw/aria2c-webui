FROM ubuntu:20.04

RUN apt-get update && apt-get install -y aria2 git nginx && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/ziahamza/webui-aria2.git /var/www/html/webui-aria2
RUN echo "server { \
    listen 80; \
    root /var/www/html/webui-aria2; \
    index index.html; \
    }" > /etc/nginx/sites-available/default
RUN mkdir /aria2 && echo "dir=/aria2/downloads\nenable-rpc=true\nrpc-listen-all=true\nrpc-listen-port=6800\nrpc-secret=YOUR_SECRET_TOKEN" > /aria2/aria2.conf
RUN mkdir /aria2/downloads
RUN echo "#!/bin/bash\naria2c --conf-path=/aria2/aria2.conf &\nnginx -g 'daemon off;'" > /start.sh && chmod +x /start.sh
EXPOSE 80
CMD ["/start.sh"]
