FROM alpine
RUN apk add nginx nginx-mod-http-brotli tini tzdata
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN apk del tzdata
COPY nginx.conf /etc/nginx/http.d/default.conf
CMD nginx -g "daemon off;"
ENTRYPOINT ["/sbin/tini", "--"]
