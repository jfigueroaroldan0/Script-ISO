#!/usr/bin/env bash

# Autor: Jesús Figueroa Roldán
# Versión: 1
# Descripción: fichero de diversas funciones
# Fecha creación: 07-03-2026

# Indica el uid del usuario actual de la shell

function f_uid {

  uid=$(id -u)
  echo "El UID del usuario $user es $uid "
}

# Para comprobar si hay conectividad con el exterior

function f_hay_conexion {

  if ping -c 1 -q 8.8.8.8 &>/dev/null;
	return 0

  else
	return 1
  fi
}

# Comprobar si estamos ejecutando el script como root

function f_eres_root {

  if [ id -u -eq 0 ] then
	return 0

  else
	return 1
  fi
}

# Función que recibe un argumento y dice si el binario está instalado

function f_bin_instalado {

  if command -v "$1" &>/dev/null; then
    return 0

  else
    return 1

 fi
}

function f_parametros {

  if [ $# -eq 0 ]; then
  echo "Error: se requiere al menos un argumento"
  echo "Uso: $0 <argumento>"

  return 1
fi

 echo "Argumentos recibidos: $#"
 echo "Primer argumento: $1"
}


