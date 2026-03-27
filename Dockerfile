# Utiliser l'image officielle Nginx la plus legere pour reduire la surface d'attaque.
FROM nginx:1-alpine-slim

# Appliquer les correctifs disponibles afin que Trivy ne bloque pas sur une CVE deja corrigee.
RUN apk upgrade --no-cache zlib

# Copier le site statique dans le repertoire web par defaut.
COPY index.html /usr/share/nginx/html/
COPY assets /usr/share/nginx/html/assets
COPY images /usr/share/nginx/html/images
COPY LICENSE.txt /usr/share/nginx/html/
COPY README.txt /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
