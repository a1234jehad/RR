# RR - Media Automation Pipeline

A complete Docker-based media automation pipeline for managing your movie and TV show collection.

## 🎯 Overview

This project sets up a comprehensive media automation stack using Docker containers. The pipeline includes automated downloading, organizing, and management of your media library.

## 📋 Requirements

### System Requirements

- **Operating System**: Windows 10/11
- **Docker Desktop**: Latest version with WSL2 backend enabled
- **PowerShell**: Windows PowerShell 5.1+ or PowerShell Core 7+
- **Storage**: Sufficient disk space for your media library

### Docker Setup

1. **Install Docker Desktop for Windows**

   - Download from [docker.com](https://www.docker.com/products/docker-desktop/)
   - Enable WSL2 integration during installation
   - Restart your computer after installation

2. **Verify Docker Installation**

   ```powershell
   docker --version
   docker run hello-world
   ```

3. **Configure Docker Resources**
   - Open Docker Desktop settings
   - Allocate sufficient RAM (8GB+ recommended)
   - Ensure file sharing is enabled for your data directories

## 🏗️ Architecture

The pipeline uses a single common volume structure (`/data`) to enable:

- **Fast moves** between download and media folders
- **Hard links** for seeding torrents without duplicating files
- **Consistent paths** across all containers

### Directory Structure

```
C:\docker\data\
├── Movies\              # Radarr managed movies
├── TV\                  # Sonarr managed TV shows
└── downloads\
    ├── torrents\        # qBittorrent downloads
    ├── usenet\          # SABnzbd downloads
    └── complete\        # Completed downloads
```

## 🚀 Services

### Currently Available

- **Radarr** - Movie collection manager
  - Port: `7878`
  - Script: `run-radarr.ps1`

### Coming Soon

- **Sonarr** - TV show collection manager
- **qBittorrent** - Torrent download client
- **SABnzbd** - Usenet download client
- **Prowlarr** - Indexer manager
- **Jellyfin/Plex** - Media server
- **Overseerr** - Request management

## 📦 Installation

### 1. Clone Repository

```powershell
git clone <repository-url>
cd RR
```

### 2. Configure Paths

Edit the path variables in each service script:

```powershell
$hostDataPath = "C:\docker\data"          # Your media storage location
$hostConfigPath = "C:\docker\radarr\config"  # Configuration storage
```

### 3. Create Directory Structure

```powershell
# Create required directories
New-Item -ItemType Directory -Force -Path "C:\docker\data\Movies"
New-Item -ItemType Directory -Force -Path "C:\docker\data\TV"
New-Item -ItemType Directory -Force -Path "C:\docker\data\downloads\torrents"
New-Item -ItemType Directory -Force -Path "C:\docker\data\downloads\usenet"
New-Item -ItemType Directory -Force -Path "C:\docker\data\downloads\complete"
```

### 4. Start Services

```powershell
# Start Radarr
.\run-radarr.ps1

# Additional services (when available)
# .\run-sonarr.ps1
# .\run-qbittorrent.ps1
# .\run-sabnzbd.ps1
```

## ⚙️ Configuration

### Service URLs

- **Radarr**: http://localhost:7878
- **Sonarr**: http://localhost:8989 _(coming soon)_
- **qBittorrent**: http://localhost:8080 _(coming soon)_
- **SABnzbd**: http://localhost:8081 _(coming soon)_

### Path Configuration

When configuring each service, use these paths:

#### Radarr Settings

- **Movies**: `/data/Movies`
- **Download Client**: Point to `/data/downloads/torrents` or `/data/downloads/usenet`

#### Future Sonarr Settings

- **TV Shows**: `/data/TV`
- **Download Client**: Point to `/data/downloads/torrents` or `/data/downloads/usenet`

## 📝 Scripts

| Script                | Service     | Port | Status         |
| --------------------- | ----------- | ---- | -------------- |
| `run-radarr.ps1`      | Radarr      | 7878 | ✅ Available   |
| `run-sonarr.ps1`      | Sonarr      | 8989 | 🚧 Coming Soon |
| `run-qbittorrent.ps1` | qBittorrent | 8080 | 🚧 Coming Soon |
| `run-sabnzbd.ps1`     | SABnzbd     | 8081 | 🚧 Coming Soon |

## 📚 Resources

- [Radarr Documentation](https://wiki.servarr.com/radarr)
- [Sonarr Documentation](https://wiki.servarr.com/sonarr)
- [Docker Documentation](https://docs.docker.com/)
- [TRaSH Guides](https://trash-guides.info/) - Excellent setup guides
