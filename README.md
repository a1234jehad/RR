# RR - Complete Media Automation Stack

A comprehensive Docker-based media automation pipeline for movies and TV shows with automatic downloading, organizing, subtitle management, and indexer integration.

## 🎯 What This Does

- **Automatically downloads** movies and TV shows when you add them
- **Manages quality** and upgrades when better versions are available  
- **Downloads subtitles** automatically in your preferred languages
- **Organizes everything** with proper naming and folder structure
- **Handles indexers** centrally so you configure them once
- **Enables fast moves** and hard links to avoid duplicate files

## 📦 Complete Stack

| Service | Purpose | Port | Access URL |
|---------|---------|------|------------|
| **Radarr** | Movie Management | 7878 | http://localhost:7878 |
| **Sonarr** | TV Show Management | 8989 | http://localhost:8989 |
| **Prowlarr** | Indexer Management | 9696 | http://localhost:9696 |
| **Bazarr** | Subtitle Management | 6767 | http://localhost:6767 |
| **qBittorrent** | Download Client | 8080 | http://localhost:8080 |

## 🏗️ Directory Structure

```
C:\docker\data\
├── Movies\              # Your movie library (managed by Radarr)
├── TV Shows\            # Your TV series library (managed by Sonarr)  
└── downloads\
    ├── torrents\        # qBittorrent downloads
    └── usenet\          # SABnzbd downloads (optional)
```

## 🚀 Quick Setup

### 1. Prerequisites
- Windows 10/11 with Docker Desktop installed
- PowerShell (any version)
- At least 8GB RAM recommended

### 2. Clone & Setup
```powershell
git clone <repository-url>
cd RR

# Create directories (optional - scripts will create them)
New-Item -ItemType Directory -Force -Path "C:\docker\data\Movies"
New-Item -ItemType Directory -Force -Path "C:\docker\data\TV Shows"
New-Item -ItemType Directory -Force -Path "C:\docker\data\downloads\torrents"
```

### 3. Start Services (Run in Order)
```powershell
# 1. Core services
.\run-radarr.ps1        # Movie management
.\run-sonarr.ps1        # TV show management

# 2. Supporting services  
.\run-prowlarr.ps1      # Indexer management
.\run-bazarr.ps1        # Subtitle management

# 3. Download client (command shown in radarr script output)
# Copy the qBittorrent command from the script output and run it
```

## ⚙️ Configuration Guide

### Step 1: Setup Download Client (qBittorrent)
1. Run the qBittorrent command from Radarr script output
2. Access http://localhost:8080
3. Default login: `admin` / `adminadmin`
4. Change password in settings

### Step 2: Setup Indexer Management (Prowlarr)
1. Access http://localhost:9696
2. Add indexers (YTS, 1337x, TorrentGalaxy, etc.)
3. Add applications:
   - **Radarr**: `http://radarr:7878` + API key
   - **Sonarr**: `http://sonarr:8989` + API key

### Step 3: Setup Subtitle Management (Bazarr)  
1. Access http://localhost:6767
2. Complete setup wizard
3. Add subtitle providers (OpenSubtitles, Subscene, etc.)
4. Connect to:
   - **Radarr**: `http://radarr:7878` + API key
   - **Sonarr**: `http://sonarr:8989` + API key

### Step 4: Configure Download Clients in Radarr/Sonarr
- **Host**: `qbittorrent` (not localhost)
- **Port**: `8080`
- **Category**: Set different categories for movies vs TV

## 🔑 Getting API Keys

API keys are needed to connect services together:

1. **Radarr**: Settings → General → Security → Copy API Key
2. **Sonarr**: Settings → General → Security → Copy API Key

Use these keys when configuring Prowlarr and Bazarr connections.

## 🔧 Important Configuration Notes

### Container Communication
- Services communicate using **container names**, not `localhost`
- Use `radarr:7878`, `sonarr:8989`, `qbittorrent:8080`, etc.
- All containers run on the `media-stack` Docker network

### Path Configuration
When configuring paths in each service:
- **Movies**: `/data/Movies`
- **TV Shows**: `/data/TV Shows`  
- **Downloads**: `/data/downloads/torrents`

### Quality Profiles
- **Movies**: HD-720p/1080p recommended
- **TV Shows**: Configure per-series preferences
- **Upgrades**: Enable automatic quality upgrades

## 📁 Available Scripts

| Script | Service | Purpose |
|--------|---------|---------|
| `run-radarr.ps1` | Radarr | Movie collection management |
| `run-sonarr.ps1` | Sonarr | TV show collection management |
| `run-prowlarr.ps1` | Prowlarr | Centralized indexer management |
| `run-bazarr.ps1` | Bazarr | Automatic subtitle downloads |

## 🎯 How It All Works Together

1. **Add Content**: Add movies to Radarr, TV shows to Sonarr
2. **Automatic Search**: Prowlarr provides indexers to both services
3. **Download**: qBittorrent downloads the content  
4. **Organization**: Radarr/Sonarr move files to proper locations
5. **Subtitles**: Bazarr automatically downloads subtitles
6. **Quality**: Services monitor for better quality releases

## 🔍 Troubleshooting

### Connection Issues
- Use container names (`radarr:7878`) not `localhost` when configuring connections
- Ensure all containers are on the `media-stack` network
- Verify API keys are correct

### Download Issues  
- Check indexer configuration in Prowlarr
- Verify download client settings use container hostname
- Ensure proper categories are set

### Path Issues
- All services must use `/data/` paths, not `C:\docker\data\`
- Verify volume mounts are correct
- Check directory permissions

## 📚 Additional Resources

- [TRaSH Guides](https://trash-guides.info/) - Comprehensive setup guides
- [Radarr Wiki](https://wiki.servarr.com/radarr) - Official documentation  
- [Sonarr Wiki](https://wiki.servarr.com/sonarr) - Official documentation
- [Docker Documentation](https://docs.docker.com/) - Container help

## ⚠️ Important Notes

- **Update paths** in scripts to match your preferred directories
- **Backup configurations** regularly  
- **Monitor disk space** - automated downloading can fill drives quickly
- **Use VPN** if required in your region
