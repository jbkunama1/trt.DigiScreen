# 🖥️ Digiscreen by La Digitale – Self‑Hosted in Docker

<p align="center">
  <img src="logo_DigiScreen.png" alt="Digiscreen Logo" width="320" />
</p>

> Ein **ultra‑einfacher**, vollständig in Docker laufender Digiscreen‑Container auf Basis des **Ulrich‑Vollpakets** (ready‑to‑use Self‑Hosting‑Variante).
> Kein Cloud‑Zwang. Keine Datenbank. Keine nervigen Builds auf dem Server.

[![License: AGPL-v3](https://img.shields.io/badge/license-AGPL--v3-blue?style=for-the-badge&logo=gnu)](https://gitlab.eldshort.de/uivens/digiscreen)
[![Docker](https://img.shields.io/badge/docker-ready-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Nginx](https://img.shields.io/badge/nginx-alpine-009639?style=for-the-badge&logo=nginx&logoColor=white)](https://hub.docker.com/_/nginx)
[![La Digitale](https://img.shields.io/badge/La_Digitale-Digiscreen-brightgreen?style=for-the-badge)](https://digiscreen.medienzentrenbw.de)
[![Maintenance](https://img.shields.io/badge/maintained-yes-success?style=for-the-badge)](https://github.com/jbkunama1/trt.DigiScreen)
[![GitLab Mirror](https://img.shields.io/badge/GitLab-Mirror-FC6D26?style=for-the-badge&logo=gitlab&logoColor=white)](https://gitlab.com/therealteacher_highfishai-group/trt-digi-screen)
[![GitHub Pages](https://img.shields.io/badge/GitHub_Pages-Docs-222?style=for-the-badge&logo=github)](https://jbkunama1.github.io/trt.DigiScreen/)

---

## 🎯 Features

- 🐳 **Ein Container** – Nginx + Digiscreen‑Vollpaket komplett in einem Image
- 🖼️ **Eigene Hintergrundbilder** – einfach in `html/assets/custom/` legen
- 🔄 **Wöchentliches Re‑Build & Restart** via Cron‑Script
- 🚀 **DietPi / Debian‑ready** – kein Node.js auf dem Server nötig
- 🧩 **Portainer‑kompatibel** – Stack‑Datei direkt importierbar
- 📱 **Responsive** – läuft im Browser, Tablet, Beamer

---

## 📁 Projektstruktur

```text
trt.DigiScreen/
├── Dockerfile
├── docker-compose.yml
├── update_digiscreen.sh
├── logo_DigiScreen.png
├── .gitignore
├── LICENSE
├── CHANGELOG.md
├── html/
│   ├── .gitkeep
│   ├── index.html              ← Digiscreen-Vollpaket (lokal entpackt)
│   ├── js/
│   ├── css/
│   └── assets/
│       ├── custom/             ← Eigene Hintergrundbilder (im Repo)
│       │   ├── .gitkeep
│       │   └── *.jpg / *.png
│       └── background.jpg      ← Original-Digiscreen-Hintergrund
├── docs/
│   └── index.html
└── README.md
```

---

## 🖼️ Eigene Hintergrundbilder verwenden

Digiscreen unterstützt eigene Hintergrundbilder. Du hast zwei Möglichkeiten:

### Option A – Einzelnes Bild (Standardhintergrund ersetzen)

Lege dein Bild direkt als `background.jpg` ins Vollpaket:

```bash
cp /pfad/zu/deinem/bild.jpg /opt/digiscreen/html/assets/background.jpg
docker compose restart
```

> 💡 Empfohlene Größe: **1920×1080 px**, Format: **JPG oder PNG**
> Bei Bedarf skalieren: `mogrify -resize 1920x1080^ -gravity Center -extent 1920x1080 -quality 80 bild.jpg`

### Option B – Mehrere eigene Bilder dauerhaft im Repo speichern

Lege deine Bilder in `html/assets/custom/` – dieser Ordner ist **vom `.gitignore` ausgenommen** und landet im Repo:

```bash
# Bilder in den Custom-Ordner kopieren
cp Designer-1.jpg /opt/digiscreen/html/assets/custom/bg_pixel_classroom.jpg
cp Designer-2.jpg /opt/digiscreen/html/assets/custom/bg_real_classroom.jpg
cp Designer-3.jpg /opt/digiscreen/html/assets/custom/bg_japan_classroom.jpg

# Ins Repo aufnehmen
git add html/assets/custom/
git commit -m "🖼️ Add custom background images"
git push
```

Danach im Digiscreen-UI unter **Einstellungen → Hintergrund** das gewünschte Bild auswählen – oder direkt als Standard setzen:

```bash
cp /opt/digiscreen/html/assets/custom/bg_pixel_classroom.jpg \
   /opt/digiscreen/html/assets/background.jpg
docker compose restart
```

> 🔁 Nach `git pull` auf dem Server sind alle Custom-Bilder sofort wieder verfügbar – kein manuelles Kopieren nötig.

---

## 📦 Schritt‑für‑Schritt‑Setup

### 1️⃣ Voraussetzungen

- Docker & Docker‑Compose installiert
- Server‑Zugriff (root oder docker‑User)
- Digiscreen‑Vollpaket‑ZIP (Ulrich Ivens) → [Download Releases](https://gitlab.eldshort.de/uivens/digiscreen/-/tree/main/releases)
- Eigenes Hintergrund‑Bild (empfohlen: mind. **1920×1080 px**, JPEG oder PNG)

---

### 2️⃣ Projektordner anlegen

```bash
mkdir -p /opt/digiscreen/{html,assets}
cd /opt/digiscreen
```

---

### 3️⃣ Digiscreen‑Vollpaket entpacken

```bash
unzip ~/Downloads/digiscreen-*.zip -d /opt/digiscreen/html
```

---

### 4️⃣ Repo klonen & Image bauen

```bash
git clone https://github.com/jbkunama1/trt.DigiScreen.git /opt/digiscreen
cd /opt/digiscreen
docker compose build --no-cache
```

---

### 5️⃣ Container starten

```bash
docker compose up -d
# Erreichbar unter: http://SERVER_IP:8080
```

---

## 🔄 Wöchentliches automatisches Update

```bash
chmod +x /opt/digiscreen/update_digiscreen.sh
sudo crontab -e
```

Eintrag:
```cron
0 3 * * 0 /opt/digiscreen/update_digiscreen.sh >> /var/log/digiscreen-update.log 2>&1
```

---

## ⚙️ Portainer‑Stack einrichten

1. **Portainer** → **Stacks** → **Add stack**
2. Name: `digiscreen`
3. `docker-compose.yml` hochladen → **Deploy the stack**

---

## 🦊 GitLab Mirror

Bei jedem Push auf `main` wird automatisch ein Mirror auf GitLab Branch `github-mirror` gepusht.
Dein originaler GitLab‑`main` bleibt unberührt.

🔗 [gitlab.com/therealteacher_highfishai-group/trt-digi-screen](https://gitlab.com/therealteacher_highfishai-group/trt-digi-screen)

---

## 🔗 Nützliche Links

| Ressource | Link |
|---|---|
| 🌐 Digiscreen BW (Medienzentren) | [digiscreen.medienzentrenbw.de](https://digiscreen.medienzentrenbw.de) |
| 📦 Ulrich Ivens Vollpaket (GitLab) | [gitlab.eldshort.de/uivens/digiscreen](https://gitlab.eldshort.de/uivens/digiscreen) |
| 📘 ZUM‑Digiscreen | [digiscreen.zum.de](https://digiscreen.zum.de) |
| 🐳 Docker Nginx Alpine | [hub.docker.com/_/nginx](https://hub.docker.com/_/nginx) |
| 🦊 GitLab Mirror | [gitlab.com/therealteacher_highfishai-group/trt-digi-screen](https://gitlab.com/therealteacher_highfishai-group/trt-digi-screen) |
| 📄 GitHub Pages Docs | [jbkunama1.github.io/trt.DigiScreen](https://jbkunama1.github.io/trt.DigiScreen/) |

---

## 📝 Lizenz

Dieses Repository enthält **nur die Docker‑/Deployment‑Konfiguration**.
Das Digiscreen‑Vollpaket selbst unterliegt der **AGPL‑v3‑Lizenz** von Ulrich Ivens / La Digitale.

---

<p align="center">
  Made with ❤️ for teachers in Baden‑Württemberg 🇩🇪<br>
  <a href="https://jbkunama1.github.io/trt.DigiScreen/">📄 Dokumentation (GitHub Pages)</a>
  &nbsp;·&nbsp;
  <a href="https://gitlab.com/therealteacher_highfishai-group/trt-digi-screen">🦊 GitLab Mirror</a>
  &nbsp;·&nbsp;
  <a href="README_EN.md">🇬🇧 English Version</a>
</p>
