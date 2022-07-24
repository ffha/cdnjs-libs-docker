FROM debian
RUN apt-get update
RUN apt-get install -y lsb-release ca-certificates apt-transport-https curl gnupg dpkg
RUN curl -sS https://n.wtf/public.key | gpg --dearmor > /usr/share/keyrings/n.wtf.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/n.wtf.gpg] https://mirror-cdn.xtom.com/sb/nginx/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/n.wtf.list
RUN apt-get update
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log
RUN apt-get install -y nginx-full
RUN mkdir /var/cache/nginx
RUN chown -R www-data:www-data /var/cache/nginx
COPY nginx.conf /etc/nginx/conf.d/server.conf
