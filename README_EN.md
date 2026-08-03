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
- 🚀 **Automatic image build** – via GitHub Actions, pushed to GHCR
- 🖼️ **Custom background images** – place them in `html/assets/custom/` (bind-mount)
- 📱 **Responsive** – optimized for 1920px, 1024px and 860px displays (patch in build)
- 🔄 **Automatic updates** – cron script or Watchtower pulls new GHCR image
- 🎛️ **Portainer‑compatible** – stack image pulled directly from ghcr.io, no local build
- 🧱 **DietPi / Debian‑ready** – no Node.js or build tools required on the host

---

## 📁 Project Structure

```text
trt.DigiScreen/
├── Dockerfile
├── docker-compose.yml        # GHCR image + custom-images bind-mount
├── nginx-custom.conf           # Nginx: Sub-Filter + Responsive-Fix
├── update_digiscreen.sh        # Pull from GHCR + restart
├── logo_DigiScreen.png
├── .gitignore
├── LICENSE
├── CHANGELOG.md
├── .github/
│   └── workflows/
│       ├── docker-build.yml    # GHCR build & push (auto)
│       └── gitlab-mirror.yml   # Mirror to GitLab
├── html/
│   └── assets/custom/          # Custom background images (bind-mount)
│       ├── custom.css          # Responsive CSS override
│       └── *.jpg / *.png       # Custom background images
├── docs/
│   └── index.html
└── README_EN.md
```

---

## 🖼️ Using Custom Background Images

Background images live in `./html/assets/custom/` as a **bind-mount** – they are MOUNTED, not baked into the image. Swap them any time without a rebuild:

```bash
# Place an image (1920×1080 recommended) into the mount folder
cp /path/to/your/image.jpg /opt/digiscreen/html/assets/custom/background.jpg

# Restart the container (mount is re-read)
docker compose restart
```

> 💡 Recommended size: **1920×1080 px**, format: **JPG or PNG**
> Resize if needed: `mogrify -resize 1920x1080^ -gravity Center -extent 1920x1080 -quality 80 image.jpg`

The mount folder lives on the **server**, not in the repo – your images stay private and survive `git pull` / image updates. The bind-mount `./html/assets/custom` persists even when a new GHCR image is pulled.

---

## 📦 Step‑by‑Step Setup

### 1️⃣ Requirements

- Docker & Docker Compose installed
- Server access (root or docker user)
- Custom background image (recommended: min. **1920×1080 px**, JPEG or PNG)

---

### 2️⃣ Clone repo (config only, no full package needed!)

```bash
git clone https://github.com/jbkunama1/trt.DigiScreen.git /opt/digiscreen
mkdir -p /opt/digiscreen/html/assets/custom
cd /opt/digiscreen
```

> ℹ️ You no longer need to download the Digiscreen full package manually – it is
> automatically baked into a GHCR image by GitHub Actions and pulled from there.

---

### 3️⃣ Start container (pulls image from GHCR)

```bash
docker compose up -d
# Available at: http://SERVER_IP:8080
```

---

## 🔄 Automatic Updates (GHCR + CI)

The image is **built automatically in GitHub Actions** (on every push to `main` + a weekly schedule) and pushed to **ghcr.io/jbkunama1/trt.DigiScreen**. The server does **nothing but pull ready-made images**.

```bash
chmod +x /opt/digiscreen/update_digiscreen.sh
sudo crontab -e
# 0 3 * * 0 /opt/digiscreen/update_digiscreen.sh >> /var/log/digiscreen-update.log 2>&1
```

The script does: `git pull` → `docker pull ghcr.io/…` → `docker compose up -d`.

### Optional alternative: Watchtower (fully automatic)

Watchtower pulls new GHCR images automatically as soon as they appear (no cron needed):

```yaml
watchtower:
  image: containrrr/watchtower
  container_name: watchtower
  restart: unless-stopped
  volumes:
    - /var/run/docker.sock:/var/run/docker.sock
  environment:
    WATCHTOWER_CLEANUP: "true"
    WATCHTOWER_SCHEDULE: "0 0 3 * * 0"   # check daily at 03:00
  networks:
    - digiscreen_net
```

> ⚠️ Watchtower updates ALL containers unless scoped. Add `watchtower.enable: "true"` as a label to the `digiscreen` service if you want to control it.

---

## ⚙️ Portainer Stack (pulls image from GHCR)

1. **Portainer** → **Stacks** → **Add stack**
2. Name: `digiscreen`
3. Upload `docker-compose.yml` → **Deploy the stack**

The stack references `ghcr.io/jbkunama1/trt.DigiScreen:latest` – **no local build** happens; the ready-built image is pulled from GHCR.

> ℹ️ **Important for first pull:** If your Portainer runner doesn't allow anonymous
> pulls from `ghcr.io`, log in once: `docker login ghcr.io -u <your-gh-username>`
> with a Personal Access Token (scope: `read:packages`). Only needed for private images.

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
