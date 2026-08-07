# 🖥️ Digiscreen by La Digitale – Self‑Hosted in Docker

<a href="https://www.buymeacoffee.com/highfish">
<img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174">
</a>

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
- 📱 **Responsive** – optimiert für 1920px, 1024px und 860px Displays
- 🔄 **Wöchentliches Re‑Build & Restart** via Cron‑Script
- 🚀 **DietPi / Debian‑ready** – kein Node.js auf dem Server nötig
- 🧩 **Portainer‑kompatibel** – Stack‑Datei direkt importierbar

---

## 📁 Projektstruktur

```text
trt.DigiScreen/
├── Dockerfile
├── docker-compose.yml
├── nginx-custom.conf           # Nginx: Sub-Filter + Responsive-Fix
├── update_digiscreen.sh
├── logo_DigiScreen.png
├── .gitignore
├── LICENSE
├── CHANGELOG.md
├── html/
│   ├── .gitkeep
│   ├── index.html              ← Digiscreen-Vollpaket (lokal entpackt)
│   └── assets/
│       └── custom/
│           ├── custom.css      ← Responsive-CSS-Override
│           └── *.jpg / *.png   ← Eigene Hintergrundbilder
├── docs/
│   └── index.html
└── README.md
```

---

## 🖼️ Eigene Hintergrundbilder verwenden

### Option A – Einzelnes Bild (Standardhintergrund ersetzen)

```bash
cp /pfad/zu/deinem/bild.jpg /opt/digiscreen/html/assets/background.jpg
docker compose restart
```

> 💡 Empfohlene Größe: **1920×1080 px** – skalieren: `mogrify -resize 1920x1080^ -gravity Center -extent 1920x1080 -quality 80 bild.jpg`

### Option B – Mehrere Bilder dauerhaft im Repo

```bash
cp mein-bild.jpg /opt/digiscreen/html/assets/custom/bg_mein_bild.jpg
git add html/assets/custom/
git commit -m "🖼️ Add custom background images"
git push
```

> 🔁 Nach `git pull` auf dem Server sofort verfügbar – kein manuelles Kopieren nötig.

---

## 📱 Responsive Display‑Support

Digiscreen läuft standardmäßig optimiert auf **1920×1080 px**. Über eine injizierte `custom.css` wird die Darstellung auch auf kleineren Screens korrekt skaliert:

| Auflösung | Skalierung | Einsatz |
|---|---|---|
| ≥ 1024px | 100% | Beamer, Full-HD Monitor |
| 860px – 1023px | 85% | Tablet quer, kleinere Monitore |
| ≤ 860px | 75% | Tablet hoch, Infodisplay |

Die Skalierung erfolgt automatisch via `nginx-custom.conf` + `html/assets/custom/custom.css` – das Vollpaket selbst wird nicht verändert.

---

## 📦 Schritt‑für‑Schritt‑Setup

### 1️⃣ Voraussetzungen

- Docker & Docker‑Compose installiert
- Server‑Zugriff (root oder docker‑User)
- Digiscreen‑Vollpaket‑ZIP → [Download Releases](https://gitlab.eldshort.de/uivens/digiscreen/-/tree/main/releases)

### 2️⃣ Repo klonen

```bash
git clone https://github.com/jbkunama1/trt.DigiScreen.git /opt/digiscreen
cd /opt/digiscreen
```

### 3️⃣ Vollpaket herunterladen & entpacken

```bash
wget "https://gitlab.eldshort.de/uivens/digiscreen/-/raw/main/releases/1.0.8/digiscreen_compiled_1.0.8.zip" \
     -O digiscreen.zip
unzip digiscreen.zip -d /opt/digiscreen/html
```

### 4️⃣ Container starten

```bash
docker compose up -d --build
# Erreichbar unter: http://SERVER_IP:8080
```

---

## 🔄 Wöchentliches automatisches Update

```bash
chmod +x update_digiscreen.sh
sudo crontab -e
# 0 3 * * 0 /opt/digiscreen/update_digiscreen.sh >> /var/log/digiscreen-update.log 2>&1
```

---

## ⚙️ Portainer‑Stack

1. **Portainer** → **Stacks** → **Add stack**
2. Name: `digiscreen`
3. `docker-compose.yml` hochladen → **Deploy the stack**

---

## 🦊 GitLab Mirror

Bei jedem Push auf `main` wird automatisch ein Mirror auf GitLab Branch `github-mirror` gepusht.

🔗 [gitlab.com/therealteacher_highfishai-group/trt-digi-screen](https://gitlab.com/therealteacher_highfishai-group/trt-digi-screen)

---

## 🔗 Nützliche Links

| Ressource | Link |
|---|---|
| 🌐 Digiscreen BW | [digiscreen.medienzentrenbw.de](https://digiscreen.medienzentrenbw.de) |
| 📦 Ulrich Ivens Vollpaket | [gitlab.eldshort.de/uivens/digiscreen](https://gitlab.eldshort.de/uivens/digiscreen) |
| 📘 ZUM‑Digiscreen | [digiscreen.zum.de](https://digiscreen.zum.de) |
| 🐳 Docker Nginx Alpine | [hub.docker.com/_/nginx](https://hub.docker.com/_/nginx) |
| 🦊 GitLab Mirror | [gitlab.com/therealteacher_highfishai-group/trt-digi-screen](https://gitlab.com/therealteacher_highfishai-group/trt-digi-screen) |
| 📄 GitHub Pages | [jbkunama1.github.io/trt.DigiScreen](https://jbkunama1.github.io/trt.DigiScreen/) |

---

## 📝 Lizenz

Dieses Repository enthält nur die Docker‑/Deployment‑Konfiguration.
Das Digiscreen‑Vollpaket unterliegt der **AGPL‑v3‑Lizenz** von Ulrich Ivens / La Digitale.

---

<p align="center">
  Made with ❤️ for teachers in Baden‑Württemberg 🇩🇪<br>
  <a href="https://jbkunama1.github.io/trt.DigiScreen/">📄 Dokumentation</a>
  &nbsp;·&nbsp;
  <a href="https://gitlab.com/therealteacher_highfishai-group/trt-digi-screen">🦊 GitLab</a>
  &nbsp;·&nbsp;
  <a href="README_EN.md">🇬🇧 English</a>
</p>

