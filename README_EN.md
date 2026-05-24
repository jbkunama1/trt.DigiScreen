# 🖥️ Digiscreen by La Digitale – Self‑Hosted in Docker

<p align="center">
  <img src="logo_DigiScreen.png" alt="Digiscreen Logo" width="320" />
</p>

> An **ultra‑simple**, fully Docker‑based Digiscreen container using the **Ulrich Ivens full package** (ready‑to‑use self‑hosting variant).
> No cloud dependency. No database. No complex builds on the server.

[![License: AGPL-v3](https://img.shields.io/badge/license-AGPL--v3-blue?style=for-the-badge&logo=gnu)](https://gitlab.eldshort.de/uivens/digiscreen)
[![Docker](https://img.shields.io/badge/docker-ready-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Nginx](https://img.shields.io/badge/nginx-alpine-009639?style=for-the-badge&logo=nginx&logoColor=white)](https://hub.docker.com/_/nginx)
[![La Digitale](https://img.shields.io/badge/La_Digitale-Digiscreen-brightgreen?style=for-the-badge)](https://digiscreen.medienzentrenbw.de)
[![Maintenance](https://img.shields.io/badge/maintained-yes-success?style=for-the-badge)](https://github.com/jbkunama1/trt.DigiScreen)
[![GitLab Mirror](https://img.shields.io/badge/GitLab-Mirror-FC6D26?style=for-the-badge&logo=gitlab&logoColor=white)](https://gitlab.com/therealteacher_highfishai-group/trt-digi-screen)
[![GitHub Pages](https://img.shields.io/badge/GitHub_Pages-Docs-222?style=for-the-badge&logo=github)](https://jbkunama1.github.io/trt.DigiScreen/)

---

## 🎯 Features

- 🐳 **Single container** – Nginx + full Digiscreen package in one image
- 🖼️ **Custom background images** – place them in `html/assets/custom/`
- 🔄 **Weekly re‑build & restart** via cron script
- 🚀 **DietPi / Debian‑ready** – no Node.js required on the host
- 🧩 **Portainer‑compatible** – stack file directly importable
- 📱 **Responsive** – runs in browser, tablet, projector

---

## 📁 Project Structure

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
│   ├── index.html              ← Digiscreen full package (extracted locally)
│   ├── js/
│   ├── css/
│   └── assets/
│       ├── custom/             ← Custom background images (tracked in repo)
│       │   ├── .gitkeep
│       │   └── *.jpg / *.png
│       └── background.jpg      ← Original Digiscreen background
├── docs/
│   └── index.html
└── README_EN.md
```

---

## 🖼️ Using Custom Background Images

Digiscreen supports custom background images. You have two options:

### Option A – Single image (replace default background)

Place your image directly as `background.jpg` in the package:

```bash
cp /path/to/your/image.jpg /opt/digiscreen/html/assets/background.jpg
docker compose restart
```

> 💡 Recommended size: **1920×1080 px**, format: **JPG or PNG**
> Resize if needed: `mogrify -resize 1920x1080^ -gravity Center -extent 1920x1080 -quality 80 image.jpg`

### Option B – Multiple images stored permanently in the repo

Place your images in `html/assets/custom/` – this folder is **excluded from `.gitignore`** and will be tracked in the repo:

```bash
# Copy images to the custom folder
cp classroom-pixel.jpg  /opt/digiscreen/html/assets/custom/bg_pixel_classroom.jpg
cp classroom-real.jpg   /opt/digiscreen/html/assets/custom/bg_real_classroom.jpg
cp classroom-japan.jpg  /opt/digiscreen/html/assets/custom/bg_japan_classroom.jpg

# Add to repo
git add html/assets/custom/
git commit -m "🖼️ Add custom background images"
git push
```

Then select the image in the Digiscreen UI under **Settings → Background**, or set it as default:

```bash
cp /opt/digiscreen/html/assets/custom/bg_pixel_classroom.jpg \
   /opt/digiscreen/html/assets/background.jpg
docker compose restart
```

> 🔁 After `git pull` on the server, all custom images are immediately available – no manual copying needed.

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

```bash
unzip ~/Downloads/digiscreen-*.zip -d /opt/digiscreen/html
```

---

### 4️⃣ Clone repo & build image

```bash
git clone https://github.com/jbkunama1/trt.DigiScreen.git /opt/digiscreen
cd /opt/digiscreen
docker compose build --no-cache
```

---

### 5️⃣ Start container

```bash
docker compose up -d
# Available at: http://SERVER_IP:8080
```

---

## 🔄 Weekly Automatic Update

```bash
chmod +x /opt/digiscreen/update_digiscreen.sh
sudo crontab -e
# 0 3 * * 0 /opt/digiscreen/update_digiscreen.sh >> /var/log/digiscreen-update.log 2>&1
```

---

## ⚙️ Portainer Stack

1. **Portainer** → **Stacks** → **Add stack**
2. Name: `digiscreen`
3. Upload `docker-compose.yml` → **Deploy the stack**

---

## 🦊 GitLab Mirror

This repo is automatically mirrored to GitLab on every push to `main`.
The mirror lands on branch **`github-mirror`** – your original GitLab `main` is never touched.

🔗 [gitlab.com/therealteacher_highfishai-group/trt-digi-screen](https://gitlab.com/therealteacher_highfishai-group/trt-digi-screen)

---

## 🔗 Useful Links

| Resource | Link |
|---|---|
| 🌐 Digiscreen BW (Medienzentren) | [digiscreen.medienzentrenbw.de](https://digiscreen.medienzentrenbw.de) |
| 📦 Ulrich Ivens Full Package | [gitlab.eldshort.de/uivens/digiscreen](https://gitlab.eldshort.de/uivens/digiscreen) |
| 📘 ZUM‑Digiscreen | [digiscreen.zum.de](https://digiscreen.zum.de) |
| 🐳 Docker Nginx Alpine | [hub.docker.com/_/nginx](https://hub.docker.com/_/nginx) |
| 🦊 GitLab Mirror | [gitlab.com/therealteacher.../trt-digi-screen](https://gitlab.com/therealteacher_highfishai-group/trt-digi-screen) |
| 📄 GitHub Pages Docs | [jbkunama1.github.io/trt.DigiScreen](https://jbkunama1.github.io/trt.DigiScreen/) |

---

## 📝 License

This repository contains **only the Docker / deployment configuration**.
The Digiscreen full package itself is licensed under **AGPL‑v3** by Ulrich Ivens / La Digitale.

---

<p align="center">
  Made with ❤️ for teachers in Baden‑Württemberg 🇩🇪<br>
  <a href="https://jbkunama1.github.io/trt.DigiScreen/">📄 Documentation (GitHub Pages)</a>
  &nbsp;·&nbsp;
  <a href="https://gitlab.com/therealteacher_highfishai-group/trt-digi-screen">🦊 GitLab Mirror</a>
  &nbsp;·&nbsp;
  <a href="README.md">🇩🇪 Deutsche Version</a>
</p>
