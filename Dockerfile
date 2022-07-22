FROM alpine
RUN apk add git nginx nginx-mod-http-brotli openssl ca-certificates nginx-mod-http-fancyindex
WORKDIR /usr/share/nginx/html
RUN git clone https://github.com/cdnjs/cdnjs.git .
RUN rm -rf .git
COPY nginx.conf /etc/nginx/http.d/server.conf
