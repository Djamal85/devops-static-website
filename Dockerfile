# Use the official Nginx image to serve the static website.
FROM nginx:alpine

# Copy the static site into the default web root.
COPY index.html /usr/share/nginx/html/
COPY assets /usr/share/nginx/html/assets
COPY images /usr/share/nginx/html/images
COPY LICENSE.txt /usr/share/nginx/html/
COPY README.txt /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
