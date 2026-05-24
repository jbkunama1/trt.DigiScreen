# =============================================================
# Digiscreen by La Digitale – Self-Hosted Docker Image
# Base: nginx:alpine (minimal & fast)
# =============================================================
FROM nginx:alpine

LABEL maintainer="therealteacher <github@arbeitermili.eu>"
LABEL description="Digiscreen by La Digitale – Self-Hosted, Ulrich Ivens Vollpaket"
LABEL version="1.0"

WORKDIR /usr/share/nginx/html

# Kopiere das komplette Digiscreen-Vollpaket aus html/
COPY html/ .

# Nginx lauscht auf Port 80
EXPOSE 80
