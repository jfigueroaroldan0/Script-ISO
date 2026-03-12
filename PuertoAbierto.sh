#!/usr/bin/env bash

#Descripción: Verifica si un servicio está escuchando en un puerto específico
#Entrada: Dirección IP o Hostname ($1) y Número de puerto ($2).
#Salida: Puerto está abierto y responde (0) o el puerto está cerrado o es inalcanzable (1).

function f_puerto_abierto() {
    timeout 2 bash -c "echo > /dev/tcp/$1/$2" >/dev/null 2>&1 && return 0 || return 1
}

HOST=$1
PUERTO=$2

f_puerto_abierto "$HOST" "$PUERTO"

if [ $? -eq 0 ]; then
    echo "Puerto abierto"
else
    echo "Puerto cerrado"
fi

f_puerto_abierto
