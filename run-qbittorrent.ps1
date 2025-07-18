# qBittorrent Docker Container Setup for Media Stack
# This script sets up qBittorrent to work with Radarr using shared networking

# IMPORTANT: Update the host paths below to match your actual directories
$hostDataPath = "C:\docker\data"  # Should match your Radarr data path
$hostConfigPath = "C:\docker\radarr\config-qbit"  # qBittorrent config path

# Ensure the media-stack network exists
Write-Host "Ensuring Docker network 'media-stack' exists..."
cmd /c "docker network create media-stack 2>nul || echo Network already exists"

# Run qBittorrent container on the media-stack network
# Use consistent /data structure matching Radarr
cmd /c "docker run --name qbittorrent --restart unless-stopped --network media-stack -d -p 8080:8080 -v `"${hostConfigPath}:/config`" -v `"${hostDataPath}:/data`" lscr.io/linuxserver/qbittorrent"

Write-Host "=== QBITTORRENT DOCKER SETUP ==="
Write-Host "qBittorrent container should now be running. Access it at http://localhost:8080"
Write-Host ""
Write-Host "=== DEFAULT LOGIN ==="
Write-Host "Default username: admin"
Write-Host "Check container logs for the temporary password:"
Write-Host "  docker logs qbittorrent"
Write-Host ""
Write-Host "=== IMPORTANT: QBITTORRENT CONFIGURATION ==="
Write-Host "In qBittorrent settings > Downloads, configure:"
Write-Host "  • Default Save Path: /data/downloads/torrents"
Write-Host "  • Keep incomplete torrents in: /data/downloads/incomplete"
Write-Host "  • Copy .torrent files to: /data/downloads/torrents"
Write-Host ""
Write-Host "=== RADARR INTEGRATION ==="
Write-Host "In Radarr > Settings > Download Clients, add qBittorrent with:"
Write-Host "  • Name: qBittorrent"
Write-Host "  • Host: qbittorrent"
Write-Host "  • Port: 8080"
Write-Host "  • Username: admin"
Write-Host "  • Password: (get from container logs)"
Write-Host "  • Category: radarr"
Write-Host ""
Write-Host "Network: Both containers are on 'media-stack' network for communication!" 