#!/bin/bash

# Request sudo password once at the beginning of the script
sudo -v

# Maintains sudo authorization during script execution
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# List of processes to kill - nothing harmfull, be carrefull if you listen music through bluetooth device, audio will be out from speaker the time it reconnects
processes=(
    "ControlCenter"
    "UniversalControl"
    "Finder"
    "bluetoothd"
    "bluetoothuserd"
    "IOUserBluetoothSerialDriver"
    "bluetoothuserd"
    "sysmond"
    "storagekitd"
    "locationd"
    "sharingd"
    "nearbyd"
    "searchpartyd"
    "airportd"
    "logd"
    "configd"
    "distnoted"
    "mDNSResponder"
    "PerfPowerServices"
    "powerd"
    "audioclocksyncd"
    "notifyd"
    "wifianalyticsd"
)

# Parcours la liste et tue les processus
for process in "${processes[@]}"; do
    PID=$(pgrep "$process")
    if [[ -n "$PID" ]]; then
        echo "Tuer $process (PID: $PID)..."
        sudo kill -9 $PID 2>/dev/null && echo "$process tué." || echo "Échec de l'arrêt de $process."
    else
        echo "$process n'est pas en cours d'exécution."
    fi
done

echo "✅ Tous les processus ont été traités."
