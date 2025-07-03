# 🔍 CAMSCAN

Escáner modular de red local para detectar dispositivos con UPnP habilitado, cámaras IP y puertos abiertos comunes. Desarrollado en Bash con soporte para logs automáticos.

---

## ⚙️ Características

- Escaneo UPnP (puerto 1900 UDP)
- Detección de cámaras IP y servicios sospechosos (`23`, `80`, `554`, `8080`, `5000`, `37777`)
- Visualización de mapeos activos UPnP (`upnpc`)
- Logging automático por fecha
- Uso sin parámetros = autodetección de subred local (`x.x.x.0/24`)

---

## 🛠️ Requisitos

- `nmap`
- (opcional) `upnpc` → instalar con `sudo pacman -S miniupnpc`

---

## ▶️ Uso

```bash
chmod +x camscan.sh
./camscan.sh              # Usa la red local por defecto
./camscan.sh 192.168.1.0/24  # O especificá una subred/IP
