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

# =============================================================
# Responsive-Patch: 1024px-Sperre auf 600px senken
# Wird nach jedem Update neu angewendet da JS-Dateien sich ändern
# =============================================================
echo "[INFO] Suche Digiscreen JS-Hauptdatei für Responsive-Patch..."

JS_FILE=$(find "$PROJECT_DIR/html/static/assets/" -name "index-*.js" ! -name "*.bak" 2>/dev/null | head -1)

if [ -z "$JS_FILE" ]; then
  echo "[WARNUNG] JS-Hauptdatei nicht gefunden – Responsive-Patch übersprungen."
else
  echo "[INFO] Patche: $JS_FILE"

  # Backup anlegen
  cp "$JS_FILE" "${JS_FILE}.bak"

  # JS-Check: Fensterbreiten-Schwellenwert 1024 → 600
  sed -i 's/t<1024?this\.alerte=!0/t<600?this.alerte=!0/g' "$JS_FILE"

  # Fehlertexte aller Sprachen patchen
  sed -i 's/mindestens 1024px/mindestens 600px/g' "$JS_FILE"
  sed -i 's/at least 1024px/at least 600px/g' "$JS_FILE"
  sed -i 's/minimale de 1024px/minimale de 600px/g' "$JS_FILE"
  sed -i 's/mínimo de 1024px/mínimo de 600px/g' "$JS_FILE"
  sed -i 's/minstens 1024px/minstens 600px/g' "$JS_FILE"
  sed -i 's/najmanje 1024px/najmanje 600px/g' "$JS_FILE"

  # Prüfen ob Patch erfolgreich
  if grep -q "t<600?this.alerte" "$JS_FILE"; then
    echo "[OK] Responsive-Patch erfolgreich angewendet (600px)."
  else
    echo "[WARNUNG] Responsive-Patch konnte nicht verifiziert werden – bitte manuell prüfen."
  fi
fi

# Status prüfen
echo "[INFO] Container-Status:"
docker ps --filter "name=$IMAGE_NAME" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo "[OK] Update abgeschlossen: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""
