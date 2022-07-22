FROM alpine
RUN apk add git nginx nginx-mod-http-brotli openssl ca-certificates nginx-mod-http-fancyindex tini wget
WORKDIR /usr/share/nginx/html
RUN git clone https://github.com/cdnjs/cdnjs.git .
RUN rm -rf .git
RUN wget https://github.com/llorephie/ngx-fancyindex-theme-bootstrap/archive/refs/tags/4.0.0-1.tar.gz
RUN tar zxvf 4.0.0-1.tar.gz
RUN cp -r ngx-fancyindex-theme-bootstrap-4.0.0-1/* ./
COPY nginx.conf /etc/nginx/http.d/server.conf
