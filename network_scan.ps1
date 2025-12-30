# network_scan.ps1
# Author: Hadi Abdelaal
# Description: Discover live hosts on local network

Write-Host "Starting Network Discovery..." -ForegroundColor Cyan

# Get local IP address
$localIP = (Get-NetIPAddress -AddressFamily IPv4 `
    | Where-Object { $_.IPAddress -notlike "169.*" }).IPAddress

$subnet = ($localIP -replace '\d+$','')

Write-Host "Local Subnet Detected: $subnet.0/24"

$aliveHosts = @()

for ($i = 1; $i -le 254; $i++) {
    $ip = "$subnet$i"
    if (Test-Connection -ComputerName $ip -Count 1 -Quiet -ErrorAction SilentlyContinue) {
        Write-Host "[+] Host Alive: $ip" -ForegroundColor Green
        $aliveHosts += $ip
    }
}

# Save results
$aliveHosts | Out-File "..\alive_hosts.txt"

Write-Host "Scan complete. Results saved to alive_hosts.txt" -ForegroundColor Yellow
