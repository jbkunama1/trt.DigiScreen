# 🖥️ Digiscreen by La Digitale – Self‑Hosted in Docker

> An **ultra‑simple**, fully Docker‑based Digiscreen container using the **Ulrich Ivens full package** (ready‑to‑use self‑hosting variant).
> No cloud dependency. No database. No complex builds on the server.

[![License: AGPL-v3](https://img.shields.io/badge/license-AGPL--v3-blue?style=for-the-badge&logo=gnu)](https://gitlab.eldshort.de/uivens/digiscreen)
[![Docker](https://img.shields.io/badge/docker-ready-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Nginx](https://img.shields.io/badge/nginx-alpine-009639?style=for-the-badge&logo=nginx&logoColor=white)](https://hub.docker.com/_/nginx)
[![La Digitale](https://img.shields.io/badge/La_Digitale-Digiscreen-brightgreen?style=for-the-badge)](https://digiscreen.medienzentrenbw.de)
[![Maintenance](https://img.shields.io/badge/maintained-yes-success?style=for-the-badge)](https://github.com/jbkunama1/trt.DigiScreen)
[![GitHub Pages](https://img.shields.io/badge/GitHub_Pages-Docs-222?style=for-the-badge&logo=github)](https://jbkunama1.github.io/trt.DigiScreen/)

---

## 🎯 Features

- 🐳 **Single container** – Nginx + full Digiscreen package in one image
- 🖼️ **Custom background image** – just place it in `html/assets/`
- 🔄 **Weekly re‑build & restart** via cron script
- 🚀 **DietPi / Debian‑ready** – no Node.js required on the host
- 🧩 **Portainer‑compatible** – stack file directly importable
- 📱 **Responsive** – runs in browser, tablet, projector

---

## 📁 Project Structure

```text
trt.DigiScreen/
├── Dockerfile                  # Docker build definition
├── docker-compose.yml          # Stack for Portainer / docker compose
├── update_digiscreen.sh        # Cron script for weekly re-build
├── html/                       # ← Extract Digiscreen full package here
│   ├── index.html
│   ├── js/
│   ├── css/
│   └── assets/
│       ├── background.jpg      # ← Your custom background image
│       └── logo.png            # ← Optional: school logo
├── docs/
│   └── index.html              # GitHub Pages documentation
└── README_EN.md
```

---

## 📦 Step‑by‑Step Setup

### 1️⃣ Requirements

- Docker & Docker Compose installed
- Server access (root or docker user)
- Digiscreen full package ZIP (Ulrich Ivens) → [Download Releases](https://gitlab.eldshort.de/uivens/digiscreen/-/tree/main/releases)
- Custom background image (recommended: min. **1920×1080 px**, JPEG or PNG)

---

### 2️⃣ Create project folder

```bash
mkdir -p /opt/digiscreen/{html,assets}
cd /opt/digiscreen
```

---

### 3️⃣ Extract Digiscreen full package

1. Download the latest ZIP from:
   → [https://gitlab.eldshort.de/uivens/digiscreen/-/tree/main/releases](https://gitlab.eldshort.de/uivens/digiscreen/-/tree/main/releases)
2. Extract contents directly into `html/`:

```bash
unzip ~/Downloads/digiscreen-*.zip -d /opt/digiscreen/html
```

> ✅ Your `html/` folder now contains `index.html`, `js/`, `css/`, `assets/` etc.

---

### 4️⃣ Set your own background image

```bash
# Replace background image
cp /path/to/your/background.jpg /opt/digiscreen/html/assets/background.jpg

# Optional: custom school logo
cp /path/to/your/logo.png /opt/digiscreen/html/assets/logo.png
```

> 💡 Recommended size: **1920×1080 px**, format: **JPG or PNG**

---

### 5️⃣ Clone this repo (get all config files)

```bash
cd /opt
git clone https://github.com/jbkunama1/trt.DigiScreen.git digiscreen
cd digiscreen
```

---

### 6️⃣ Build Docker image

```bash
docker compose build --no-cache
```

---

### 7️⃣ Start container

```bash
docker compose up -d
```

✅ Digiscreen is now available at:
```
http://SERVER_IP:8080
```

---

## 🔄 Weekly Automatic Update

### Make script executable

```bash
chmod +x /opt/digiscreen/update_digiscreen.sh
```

### Set up cron job (every Sunday at 03:00 AM)

```bash
sudo crontab -e
```

Add entry:
```cron
0 3 * * 0 /opt/digiscreen/update_digiscreen.sh >> /var/log/digiscreen-update.log 2>&1
```

> 📋 Log file location: `/var/log/digiscreen-update.log`

---

## ⚙️ Portainer Stack Setup

1. Open **Portainer** → **Stacks** → **Add stack**
2. Name: `digiscreen`
3. Select: `Upload` or `Web editor`
4. Upload `docker-compose.yml` (or paste the content)
5. Click **Deploy the stack**

> 🔁 For re‑builds: stop stack → rebuild image → restart stack
> or just let the cron script handle it automatically.

---

## 🖼️ Assets Structure

```text
html/assets/
├── background.jpg     ← your custom background image
├── logo.png           ← optional school logo
└── ...                ← original Digiscreen assets remain
```

---

## 🔗 Useful Links

| Resource | Link |
|---|---|
| 🌐 Digiscreen BW (Medienzentren) | [digiscreen.medienzentrenbw.de](https://digiscreen.medienzentrenbw.de) |
| 📦 Ulrich Ivens Full Package (GitLab) | [gitlab.eldshort.de/uivens/digiscreen](https://gitlab.eldshort.de/uivens/digiscreen) |
| 📘 ZUM‑Digiscreen | [digiscreen.zum.de](https://digiscreen.zum.de) |
| 🐳 Docker Nginx Alpine | [hub.docker.com/_/nginx](https://hub.docker.com/_/nginx) |
| 📄 GitHub Pages Docs | [jbkunama1.github.io/trt.DigiScreen](https://jbkunama1.github.io/trt.DigiScreen/) |

---

## 📝 License

This repository contains **only the Docker / deployment configuration**.
The Digiscreen full package itself is licensed under **AGPL‑v3** by Ulrich Ivens / La Digitale.

---

<p align="center">
  Made with ❤️ for teachers in Baden‑Württemberg 🇩🇪<br>
  <a href="https://jbkunama1.github.io/trt.DigiScreen/">📄 Documentation (GitHub Pages)</a>
</p>
