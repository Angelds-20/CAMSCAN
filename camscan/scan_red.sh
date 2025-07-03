#!/bin/bash

# Escaneo modular de red local: UPnP + cámaras + puertos abiertos
# Con logging automático por fecha

# ---------------------- FUNCIONES ----------------------

validar_ip() {
    local ip="$1"
    if [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        return 0
    else
        return 1
    fi
}

obtener_subred_local() {
    local ip
    ip=$(ip addr show | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' | cut -d/ -f1 | head -n1)
    echo "$(echo "$ip" | cut -d"." -f1-3).0/24"
}

scan_upnp_udp() {
    echo "🔍 [1/3] Escaneando UPnP en $1 (UDP puerto 1900)..."
    sudo nmap -sU -Pn -p 1900 --script=upnp-info "$1"
}

scan_camaras() {
    echo "📷 [2/3] Buscando cámaras o servicios sospechosos en $1..."
    sudo nmap -sS -Pn -p 23,80,554,37777,5000,8080 "$1"
}

listar_upnp_mapeos() {
    echo "📤 [3/3] Mapeos UPnP activos..."
    if command -v upnpc >/dev/null 2>&1; then
        upnpc -l
    else
        echo "❌ No se encontró 'upnpc'. Instalalo con: sudo pacman -S miniupnpc"
    fi
}

# ---------------------- PRINCIPAL ----------------------

# Carpeta logs
logdir="$HOME/camscan/logs"
mkdir -p "$logdir"

# Archivo log con fecha y hora
logfile="$logdir/scan_red_$(date +'%Y%m%d_%H%M%S').log"

# IP o red como argumento
target="$1"

# Si no se pasó argumento, usar red local automáticamente
if [ -z "$target" ]; then
    target=$(obtener_subred_local)
    echo "ℹ️  No se especificó IP o subred. Usando red local: $target"
fi

# Validación
if ! validar_ip "$(echo "$target" | cut -d/ -f1)"; then
    echo "❌ IP inválida: $target"
    exit 1
fi

# Ejecutar y guardar salida con tee (pantalla + archivo)
{
    echo ""
    echo "📡 Escaneo iniciado en: $target"
    echo "----------------------------------------------------"

    scan_upnp_udp "$target"
    echo "----------------------------------------------------"
    scan_camaras "$target"
    echo "----------------------------------------------------"
    listar_upnp_mapeos

    echo ""
    echo "✅ Escaneo completo."
} | tee "$logfile"

echo ""
echo "📝 Resultado guardado en: $logfile"

