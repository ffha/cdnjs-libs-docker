FROM alpine
RUN apk add nginx nginx-mod-http-brotli tini
COPY nginx.conf /etc/nginx/http.d/default.conf
CMD nginx -g "daemon off;"
ENTRYPOINT ["/sbin/tini", "--"]
