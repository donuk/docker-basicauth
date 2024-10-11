FROM nginx:1.27.2

RUN apt-get update && apt-get install -y apache2-utils && apt-get clean
ADD ./setup-basic-auth.sh /docker-entrypoint.d/99-setup-basic-auth.sh
ENV AUTH_REASON="Authentication Required"
