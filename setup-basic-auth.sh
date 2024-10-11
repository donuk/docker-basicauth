#!/bin/bash -e

main() {
    generate_htpasswd_file > /etc/nginx/htpasswd
    generate_nginx_proxy_conf /etc/nginx/htpasswd > /etc/nginx/conf.d/default.conf
}

generate_htpasswd_file() {
    set | grep LOGIN | grep -v grep | sed 's/.*=//; s/:/ /' | while read name pass; do
        htpasswd -nb $(printf "%q" "$name") $(printf "%q" "$pass")
    done
}
generate_nginx_proxy_conf() {
    PASSWDFILE="$1"
    cat <<EOF
server {
    listen       80 default;
    server_name  localhost;
    location / {
        proxy_pass   http://$BACKEND;
        proxy_pass_request_headers      on;
        auth_basic "$AUTH_REASON";
        auth_basic_user_file $PASSWDFILE;
    }
}
EOF
}

main
