FROM debian:stable-slim
RUN curl -sS https://n.wtf/public.key | gpg --dearmor > /usr/share/keyrings/n.wtf.gpg
ENV LANG zh_CN.UTF-8
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/n.wtf.gpg] https://mirror-cdn.xtom.com/sb/nginx/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/n.wtf.list
RUN apt-get update && apt-get install -y lsb-release ca-certificates apt-transport-https curl gnupg dpkg locales nginx-extras git && rm -rf /var/lib/apt/lists/* && localedef -i zh_CN -c -f UTF-8 -A /usr/share/locale/locale.alias zh_CN.UTF-8
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log
RUN mkdir /var/cache/nginx
RUN chown -R www-data:www-data /var/cache/nginx
COPY nginx.conf /etc/nginx/conf.d/server.conf
ARG TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]
CMD ["nginx", "-g", "daemon off;"]
