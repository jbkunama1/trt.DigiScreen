# 📝 Changelog – trt.DigiScreen

Alle relevanten Änderungen an diesem Projekt werden hier dokumentiert.
Format basiert auf [Keep a Changelog](https://keepachangelog.com/de/1.0.0/).

---

## [Unreleased]

---

## [1.1.0] – 2026-05-24

### Added
- 🦊 GitLab Mirror via GitHub Actions (Branch: `github-mirror`)
- 🖼️ `logo_DigiScreen.png` – Projektlogo erstellt und ins Repo eingebunden
- 🇬🇧 `README_EN.md` – englische Übersetzung der Hauptdokumentation
- 🌐 `docs/index.html` – zweisprachige GitHub Pages Dokumentationsseite (DE/EN)
- 📋 `CHANGELOG.md` – diese Datei
- 🚫 `.gitignore` – `html/`-Ordner (Vollpaket) vom Git-Tracking ausgeschlossen
- 📂 `html/.gitkeep` – Platzhalter damit `html/`-Ordner im Repo sichtbar ist
- ⚖️ `LICENSE` – AGPL-v3 Lizenzdatei hinzugefügt

### Changed
- 🔗 README.md: GitLab Mirror Link + Shield Badge ergänzt
- 🔗 README.md: Logo oben zentriert eingebunden
- 🔗 README_EN.md: Logo, GitLab Mirror Link + Shield Badge ergänzt

---

## [1.0.0] – 2026-05-24

### Added
- 🎉 Initial Commit: Komplettes Docker-Setup für Digiscreen by La Digitale
- 🐳 `Dockerfile` – nginx:alpine + Digiscreen Vollpaket
- ⚙️ `docker-compose.yml` – Portainer-kompatibler Stack
- 🔄 `update_digiscreen.sh` – wöchentliches Re-Build & Restart Script
- 🇩🇪 `README.md` – deutsche Hauptdokumentation mit Shields & Emojis
- 🌐 `docs/index.html` – GitHub Pages Dokumentation
