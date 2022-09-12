FROM alpine
RUN apk add nginx nginx-mod-http-brotli git tini tzdata
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN apk del tzdata
WORKDIR /app
COPY index.html .
RUN git clone https://github.com/cdnjs/cdnjs.git .
COPY nginx.conf /etc/nginx/http.d/default.conf
CMD nginx -g "daemon off; error_log /dev/stderr;"
ENTRYPOINT ["/sbin/tini", "--"]
STOPSIGNAL SIGQUIT
