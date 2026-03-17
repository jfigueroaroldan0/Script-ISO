#!/usr/bin/env bash

# Autores: Jesús Figueroa Roldán, Iván Jiménez Moreno, Ismael Cotán Rayas, Abraham Begines Ruíz Y Jose Manuel López Hueso
# Versión: 1
# Descripción: fichero de funciones
# Fecha creación: 09-03-2026

# Colores

rojo='\033[31m'
verde='\033[32m'
amarillo='\033[33m'
azul='\033[34m'
magenta='\033[35m'
cian='\033[36m'
blanco='\033[37m'
reset='\033[0m'
negrita='\033[1m'

# Funciones

# Indica el uid del usuario actual de la shell.
# Entrada: no necesita
# Salida: muestra el uid del usuario que ejecuta el script

f_uid() {
  uid=$(id -u)
  echo "El UID del usuario $USER es $uid "
  return 0
}

# Indica los 10 comandos más utilizados en la shell
# Entrada: no necesita
# Salida: muestra los 10 comandos más usados en la shell actual
# No funciona en la shell sh

f_ranking_comandos() {
  cat ~/.bash_history | sort | uniq -c | sort -rn | head -10
}

#Comprueba que se han introducido argumentos al script.
#Entrada: Argumento
#Salida: Mensaje de error si no hay argumento

f_parametros() {
    if [ $# -eq 0 ]; then
        echo "Error: no se han introducido argumentos"
        exit 1
    fi
}

f_parametros "$@"

echo "Argumentos recibidos: $@"

# Indica si un binario esta instalado.
# Entrada: el binario.
# Salida: devuelve 0 si está 1 si no está.

f_bin_instalado() {
    if command -v "$1" > /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# Indica si tienes conexion.
# Entrada: no tiene.
# Salida: devuelve 0 si tienes conexión 1 si no tienes.

f_hay_conexion() {
    if ping -q -c 1 8.8.8.8 > /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# Entrada: nada
# Salida: Devuelve 0 si ejecuta root

f_eres_root() {

  uid=$(id -u)

  if [ "$uid" -eq 0 ]; then

    echo "Este programa se ha ejecutado con permisos de administrador"
    return 0

  else

    echo "El programa se ha ejecutado sin permisos de administrador"
    exit 1

  fi
}

#Entrada: nombre del paquete a buscar
#Salida: 0 en caso de estar disponible

f_paquete_disponible() {

  paquete=$1

  if dpkg -s "$1" >/dev/null 2>&1; then

    echo "El paquete está disponible"
    return 0

  else

    echo "El paquete no está disponible"
    exit 1
  fi
}

# Indica si un paquete está instalado o no
# Entrada: nombre del paquete
# Salida: muestra 0 si está instalado, 1 si no está instalado

f_paquete_instalado() {
  echo $(dpkg -s "$1" >/dev/null 2>&1; echo $?)
}

# Indica el paquete que proporciona un comando o binario
# Entrada: nombre del comando
# Salida: muestra el nombre del paquete

f_buscar_paquetes() {
    local cmd="$1"

  if command -v "$cmd" >/dev/null 2>&1; then
    dpkg -S "$(command -v "$cmd")"

  else
    if ! command -v apt-file >/dev/null 2>&1; then
      echo "Instala apt-file: sudo apt install apt-file"
      return 1
    fi
    apt-file search "$cmd"
  fi
}

}
