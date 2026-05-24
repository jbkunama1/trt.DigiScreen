#!/bin/bash
# =============================================================
# Digiscreen – Wöchentliches Re-Build & Restart Script
# Cron: 0 3 * * 0 /opt/digiscreen/update_digiscreen.sh >> /var/log/digiscreen-update.log 2>&1
# =============================================================

PROJECT_DIR="/opt/digiscreen"
IMAGE_NAME="digiscreen"
LOG_DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "====================================="
echo "[$LOG_DATE] Starte wöchentliches Digiscreen-Update..."
echo "====================================="

cd "$PROJECT_DIR" || {
  echo "[FEHLER] Verzeichnis $PROJECT_DIR nicht gefunden. Abbruch."
  exit 1
}

# Optional: neuestes Repo ziehen (falls git vorhanden)
if [ -d ".git" ]; then
  echo "[INFO] Git-Pull des Repos..."
  git pull origin main
fi

# Altes Image stoppen
echo "[INFO] Container stoppen..."
docker compose down

# Neues Image bauen (kein Cache)
echo "[INFO] Image neu bauen (--no-cache)..."
docker compose build --no-cache

# Container neu starten
echo "[INFO] Container starten..."
docker compose up -d

# Status prüfen
echo "[INFO] Container-Status:"
docker ps --filter "name=$IMAGE_NAME" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo "[OK] Update abgeschlossen: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""
