#!/usr/bin/env bash

# Autor: Jesús Figueroa Roldán
# Versión: 1
# Descripción: fichero de diversas funciones
# Fecha creación: 07-03-2026

# Indica el uid del usuario actual de la shell.
# Entrada: no necesita
# Salida: muestra el uid del usuario que ejecuta el script

function f_uid {

f_uid() {

uid=$(id -u)

  if [ "$uid" -eq 0 ]; then
    return $uid

  else
    echo "No puede continuar la ejecución del script porque no eres root"
    return $uid
  fi
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

# Comprueba que se han introducido argumentos al script

function f_parametros {

  if [ $# -eq 0 ]; then
  echo "Error: se requiere al menos un argumento"
  echo "Uso: $0 <argumento>"

  return 1
fi

 echo "Argumentos recibidos: $#"
 echo "Primer argumento: $1"
}

# Devuelve cero en caso de estar instalado el paquete pasado como argumento, uno en caso contrario

f_paquete_instalado {
    
  dpkg -l "$1" &>/dev/null
}

# Indica los 10 comandos más utilizados en la shell
# Descripción: Muestra los comandos más utilizados
# Entrada: no admite
# Salida: top 10 comandos que más se han utilizado

f_ranking_comandos() {

cat ~/.bash_history | sort | uniq -c | sort -rn | head -10

}
