FROM nginx:alpine
# Copy the custom HTML file to the default Nginx HTML directory
COPY index.html /usr/share/nginx/html/index.html