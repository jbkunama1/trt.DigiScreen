# =============================================================
# Digiscreen by La Digitale – Self-Hosted Docker Image
# Base: nginx:alpine (minimal & fast)
# Das Vollpaket wird im GitHub-Actions-Build geladen und hier
# via Build-Arg dokumentiert (für Labels/Sichtbarkeit).
# =============================================================
FROM nginx:alpine

LABEL maintainer="therealteacher <github@arbeitermili.eu>"
LABEL description="Digiscreen by La Digitale – Self-Hosted, Ulrich Ivens Vollpaket"
LABEL org.opencontainers.image.source="https://github.com/jbkunama1/trt.DigiScreen"

# Version des Digiscreen-Vollpakets (vom Workflow gesetzt)
ARG DIGISCREEN_VERSION="unknown"
LABEL org.opencontainers.image.version="${DIGISCREEN_VERSION}"

WORKDIR /usr/share/nginx/html

# Kopiere das komplette Digiscreen-Vollpaket aus html/
# (vom GitHub-Actions-Workflow vorab heruntergeladen & gepatcht)
COPY html/ .

# Nginx lauscht auf Port 80
EXPOSE 80
