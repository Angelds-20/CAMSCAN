# 🔍 CAMSCAN

Modular local network scanner to detect devices with UPnP enabled, IP cameras, and common open ports. Developed in Bash with support for automatic logging.

---

## ⚙️ Features

- UPnP scanning (UDP port 1900)
- Detection of IP cameras and suspicious services (`23`, `80`, `554`, `8080`, `5000`, `37777`)
- Display of active UPnP mappings (`upnpc`)
- Automatic date-based logging
- No parameters = automatic detection of local subnet (`x.x.x.0/24`)

---

## 🛠️ Requirements

- `nmap`
- (optional) `upnpc` → install with `sudo pacman -S miniupnpc` -- `sudo apt update && sudo apt install miniupnpc`

---

## ▶️ Usage

```bash
cd CAMSCAN && cd camscan
chmod +x camscan.sh
./scan_red.sh              # Uses local network by default
./scan_red.sh 192.168.1.0/24  # Or specify a subnet/IP
