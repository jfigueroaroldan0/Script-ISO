#!/usr/bin/env bash

# Función que recibe un parámetro y comprueba si está instalado
# Devuelve 0 en caso de estar instalado y 1 si no está instalado

f_bin_instalado() {

  if command -v "$1" &>/dev/null; then
    return 0

  else
    return 1

 fi
}

f_bin_instalado $1
