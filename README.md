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
- 🖼️ **Eigenes Hintergrundbild** – einfach in `html/assets/` legen
- 🔄 **Wöchentliches Re‑Build & Restart** via Cron‑Script
- 🚀 **DietPi / Debian‑ready** – kein Node.js auf dem Server nötig
- 🧩 **Portainer‑kompatibel** – Stack‑Datei direkt importierbar
- 📱 **Responsive** – läuft im Browser, Tablet, Beamer

---

## 📁 Projektstruktur

```text
trt.DigiScreen/
├── Dockerfile                  # Docker‑Build‑Definition
├── docker-compose.yml          # Stack für Portainer / docker compose
├── update_digiscreen.sh        # Cron‑Script für wöchentlichen Re‑Build
├── logo_DigiScreen.png         # Projekt‑Logo
├── html/                       # ← Hier das Digiscreen‑Vollpaket entpacken
│   ├── index.html
│   ├── js/
│   ├── css/
│   └── assets/
│       ├── background.jpg      # ← Dein eigenes Hintergrundbild
│       └── logo.png            # ← Optional: Schullogo
├── docs/
│   └── index.html              # GitHub Pages Dokumentation
└── README.md
```

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

1. Lade die neueste ZIP von:
   → [https://gitlab.eldshort.de/uivens/digiscreen/-/tree/main/releases](https://gitlab.eldshort.de/uivens/digiscreen/-/tree/main/releases)
2. Entpacke den Inhalt direkt in `html/`:

```bash
unzip ~/Downloads/digiscreen-*.zip -d /opt/digiscreen/html
```

> ✅ Dein `html/`‑Ordner enthält jetzt `index.html`, `js/`, `css/`, `assets/` etc.

---

### 4️⃣ Eigenes Hintergrundbild einsetzen

```bash
# Hintergrundbild ersetzen
cp /pfad/zu/deinem/background.jpg /opt/digiscreen/html/assets/background.jpg

# Optional: eigenes Schullogo
cp /pfad/zu/deinem/logo.png /opt/digiscreen/html/assets/logo.png
```

> 💡 Empfohlene Bildgröße: **1920×1080 px**, Dateiformat: **JPG oder PNG**

---

### 5️⃣ Repo klonen (alle Config‑Dateien holen)

```bash
cd /opt
git clone https://github.com/jbkunama1/trt.DigiScreen.git digiscreen
cd digiscreen
```

---

### 6️⃣ Docker‑Image bauen

```bash
docker compose build --no-cache
```

---

### 7️⃣ Container starten

```bash
docker compose up -d
```

✅ Digiscreen ist jetzt erreichbar unter:
```
http://SERVER_IP:8080
```

---

## 🔄 Wöchentliches automatisches Update

### Script ausführbar machen

```bash
chmod +x /opt/digiscreen/update_digiscreen.sh
```

### Cron‑Job einrichten (jeden Sonntag um 03:00 Uhr)

```bash
sudo crontab -e
```

Eintrag hinzufügen:
```cron
0 3 * * 0 /opt/digiscreen/update_digiscreen.sh >> /var/log/digiscreen-update.log 2>&1
```

> 📋 Das Log findest du unter: `/var/log/digiscreen-update.log`

---

## ⚙️ Portainer‑Stack einrichten

1. Öffne **Portainer** → **Stacks** → **Add stack**
2. Name: `digiscreen`
3. Wähle: `Upload` oder `Web editor`
4. Lade `docker-compose.yml` hoch (bzw. kopiere den Inhalt)
5. Klicke **Deploy the stack**

> 🔁 Für Re‑Builds: Stack stoppen → Image neu bauen → Stack starten
> oder Cron‑Script laufen lassen (läuft unabhängig von Portainer)

---

## 🖼️ Assets‑Struktur

```text
html/assets/
├── background.jpg     ← dein eigenes Hintergrundbild
├── logo.png           ← optional Schullogo
└── ...                ← Original‑Digiscreen‑Assets bleiben erhalten
```

---

## 🔗 Nützliche Links

| Ressource | Link |
|---|---|
| 🌐 Digiscreen BW (Medienzentren) | [digiscreen.medienzentrenbw.de](https://digiscreen.medienzentrenbw.de) |
| 📦 Ulrich Ivens Vollpaket (GitLab) | [gitlab.eldshort.de/uivens/digiscreen](https://gitlab.eldshort.de/uivens/digiscreen) |
| 📘 ZUM‑Digiscreen | [digiscreen.zum.de](https://digiscreen.zum.de) |
| 🐳 Docker Nginx Alpine | [hub.docker.com/_/nginx](https://hub.docker.com/_/nginx) |
| 🦊 GitLab Mirror (trt-digi-screen) | [gitlab.com/therealteacher_highfishai-group/trt-digi-screen](https://gitlab.com/therealteacher_highfishai-group/trt-digi-screen) |
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
</p>
