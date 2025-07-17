# Radarr Docker Container Setup with Optimized Volume Structure
# This script uses the recommended single common volume approach to enable fast moves and hard links

# IMPORTANT: Update the host paths below to match your actual directories
$hostDataPath = "C:\docker\data"  # Change this to your preferred host path
$hostConfigPath = "C:\docker\radarr\config"  # Change this to your preferred config path

# Use cmd /c to run the command in Command Prompt 
cmd /c "docker run --name radarr --restart unless-stopped -d -p 7878:7878 -v ${hostConfigPath}:/config -v ${hostDataPath}:/data ghcr.io/hotio/radarr"

Write-Host "=== RADARR DOCKER SETUP ==="
Write-Host "Radarr container should now be running. Access it at http://localhost:7878"
Write-Host ""
Write-Host "=== IMPORTANT: DIRECTORY STRUCTURE ==="
Write-Host "Make sure your host directory structure looks like this:"
Write-Host "  $hostDataPath\"
Write-Host "    Movies\           (for your movie library)"
Write-Host "    downloads\"
Write-Host "      torrents\       (for torrent downloads)"
Write-Host "      usenet\         (for usenet downloads)"
Write-Host ""
Write-Host "=== RADARR CONFIGURATION ==="
Write-Host "In Radarr settings, configure your paths as:"
Write-Host "  • Movies: /data/Movies"
Write-Host "  • Download folders: /data/downloads/torrents and/or /data/downloads/usenet"
Write-Host ""
Write-Host "=== DOWNLOAD CLIENT EXAMPLES ==="
Write-Host "When setting up download clients, use the SAME /data volume:"
Write-Host ""
Write-Host "qBittorrent:"
$qbitCommand = "docker run --name qbittorrent -d -p 8080:8080 -v `"${hostConfigPath}-qbit:/config`" -v `"${hostDataPath}:/data`" lscr.io/linuxserver/qbittorrent"
Write-Host "  $qbitCommand"
Write-Host ""
Write-Host "SABnzbd:"
$sabCommand = "docker run --name sabnzbd -d -p 8081:8080 -v `"${hostConfigPath}-sab:/config`" -v `"${hostDataPath}:/data`" lscr.io/linuxserver/sabnzbd"
Write-Host "  $sabCommand"
Write-Host ""
Write-Host "This ensures fast moves and hard links work properly!" 