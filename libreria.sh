#!/usr/bin/env bash

# ============================================================
# Librería de funciones de administración de sistemas
# Autores:
#   - Jesús Figueroa Roldán
#   - Iván Jiménez Moreno
#   - Ismael Cotán Rayas
#   - Abraham Begines Ruiz
#   - Jose Manuel López Hueso
#   - Germán C.
# Versión: 1.0
# Fecha de creación: 2026-03-09
# ============================================================

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

# ============================================================
# f_uid
# Descripción: Indica el uid del usuario actual de la shell.
# Entrada: No necesita argumentos.
# Salida: Muestra el uid del usuario que ejecuta el script.
# ============================================================

f_uid() {
  uid=$(id -u)
  echo "El UID del usuario $USER es $uid "
  return 0
}

# ============================================================
# f_ranking_comandos
# Descripción: Indica los 10 comandos más utilizados en la shell.
# Entrada: No necesita argumentos.
# Salida: Muestra los 10 comandos más usados en la shell actual. No funciona en sh.
# ============================================================

f_ranking_comandos() {
  cat ~/.bash_history | sort | uniq -c | sort -rn | head -10
}


# ============================================================
# f_parametros
# Descripción: Comprueba que se han introducido argumentos al script.
# Entrada: Los argumentos pasados al script.
# Salida: Mensaje de error y exit 1 si no se han introducido argumentos.
# ============================================================

f_parametros() {
    if [ $# -eq 0 ]; then
        echo "Error: no se han introducido argumentos"
        exit 1
    fi
}

# ============================================================
# f_bin_instalado
# Descripción: Indica si un binario está instalado en el sistema.
# Entrada: $1: Nombre del binario.
# Salida: 0 si está instalado, 1 si no está.
# ============================================================

f_bin_instalado() {
    if command -v "$1" > /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# ============================================================
# f_hay_conexion
# Descripción: Indica si hay conexión a Internet.
# Entrada: No necesita argumentos.
# Salida: 0 si hay conexión, 1 si no hay.
# ============================================================

f_hay_conexion() {
    if ping -q -c 1 8.8.8.8 > /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}


# ============================================================
# f_eres_root
# Descripción: Comprueba si el script se está ejecutando con permisos de root.
# Entrada: No necesita argumentos.
# Salida: 0 si se ejecuta como root, exit 1 si no.
# ============================================================

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


# ============================================================
# f_paquete_disponible
# Descripción: Comprueba si un paquete está disponible en el sistema.
# Entrada: $1: Nombre del paquete a buscar.
# Salida: 0 si está disponible, exit 1 si no lo está.
# ============================================================

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


# ============================================================
# f_paquete_instalado
# Descripción: Indica si un paquete está instalado o no.
# Entrada: $1: Nombre del paquete.
# Salida: 0 si está instalado, 1 si no está instalado.
# ============================================================

f_paquete_instalado() {
  echo $(dpkg -s "$1" >/dev/null 2>&1; echo $?)
}


# ============================================================
# f_buscar_paquetes
# Descripción: Indica el paquete que proporciona un comando o binario.
# Entrada: $1: Nombre del comando.
# Salida: Muestra el nombre del paquete que lo provee. Devuelve 1 si apt-file no está instalado.
# ============================================================

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


# ============================================================
# f_espacio_libre
# Descripción: Muestra si hay espacio disponible en el punto de montaje.
# Entrada: $1: El punto de montaje. $2: La cantidad mínima de espacio libre en porcentaje.
# Salida: 0 si hay espacio, 1 si no hay o no existe el punto de montaje.
# ============================================================

function f_espacio_libre() {
 porcentaje=$(df -h "$1" 2>/dev/null | tail -1 | awk '{print $5}' | sed 's/%//');
 porcentaje_libre=$((100 - porcentaje))

 if [ -z "$porcentaje" ]; then
  echo "Error: Punto de montaje '$1' no existe"; 
  return 1
 fi

 if [ $porcentaje_libre -ge ${2:-10} ]; then
  return 0;
 else
  return 1;
 fi
 
}


# ============================================================
# f_log
# Descripción: Registra un evento en un archivo de log cronológico. ¡¡¡SE NECESITA SER SUDO!!!
# Entrada: $1: El mensaje que se quiere registrar. $2 (opcional): Ruta del fichero de log (por defecto /var/log/sysadmin.log).
# Salida: 0 si se ha registrado correctamente, 1 si da error.
# ============================================================

f_log() {
echo "$(date '+%Y-%m-%d %H:%M:%S')  $1" >> "${2:-/var/log/sysadmin.log}"
}


# ============================================================
# f_verificar_hash
# Descripción: Devuelve si el archivo está íntegro o no mediante una comparación hash md5.
# Entrada: $1: Ruta del archivo. $2: Último hash md5 conocido del archivo.
# Salida: 0 si permanece íntegro, exit 1 en caso contrario.
# ============================================================

f_verificar_hash() {
  hash=$(md5sum $1 | awk '{print $1}')

  if [ "$hash" = "$2" ]; then
    return 0
  else
    exit 1
  fi
}


# ============================================================
# f_borrar_duplicados
# Descripción: Busca archivos duplicados en un directorio comparando su hash SHA256.
# Entrada: $1: Ruta del directorio a analizar. $2: Modo de operación (CHECK para listar duplicados, DELETE para eliminarlos).
# Salida: 0 si se ejecuta correctamente, 1 si el directorio no existe.
# ============================================================

f_borrar_duplicados() {
    dir="$1"
    modo="$2"

    if [[ ! -d "$dir" ]]; then
        echo "Error: directorio no existe."
        return 1
    fi

    tmp=$(mktemp)

    find "$dir" -type f | while read file; do
        hash=$(sha256sum "$file" | awk '{print $1}')
        if grep -q "$hash" "$tmp"; then
            if [[ "$modo" == "CHECK" ]]; then
                echo "Duplicado: $file"
            elif [[ "$modo" == "DELETE" ]]; then
                rm "$file"
                echo "Eliminado: $file"
            fi
        else
            echo "$hash" >> "$tmp"
        fi
    done

    rm "$tmp"
    return 0
}


# ============================================================
# f_puerto_abierto
# Descripción: Verifica si un servicio está escuchando en un puerto específico.
# Entrada: $1: Dirección IP o Hostname. $2: Número de puerto.
# Salida: 0 si el puerto está abierto y responde, 1 si está cerrado o es inalcanzable.
# ============================================================

function f_puerto_abierto() {
    timeout 2 bash -c "echo > /dev/tcp/$1/$2" >/dev/null 2>&1 && return 0 || return 1
}


# ============================================================
# f_es_ip_valida
# Descripción: Valida sintácticamente si una cadena tiene formato de IPv4.
# Entrada: $1: Cadena de texto a validar.
# Salida: 0 si el formato de IP es correcto, 1 si el formato es inválido (imprime error por stderr).
# ============================================================

f_es_ip_valida() {

    echo "$1" | grep -E '^([0-9]{1,3}\.){3}[0-9]{1,3}$' >/dev/null

    if [ $? -eq 0 ]; then
        return 0
    else
        echo "Error: formato IPv4 inválido" >&2
        return 1
    fi

}


# ============================================================
# f_limpiar_temporales
# Descripción: Elimina los ficheros de un directorio con más de X días de antigüedad.
# Entrada: Ruta del directorio (introducida de forma interactiva). Edad mínima de los ficheros en días (introducida de forma interactiva).
# Salida: 0 si la limpieza se realiza correctamente, 1 si el directorio no existe.
# ============================================================

f_limpiar_temporales() {

read -e -p "Ruta del directorio: " ruta
read -p "Edad de los ficheros en días: " dias

if [ ! -d "$ruta" ]; then
  echo "Error"
  return 1

else
  find "$ruta" -type f -mtime +$dias -delete
  echo "Limpieza terminada"
  return 0
fi
}


# ============================================================
# f_generar_logins_universal
# Descripción: Genera identificadores en minúsculas procesando nombres y apellidos. Compatible con /bin/sh.
# Entrada: $1: Fichero origen (CSV delimitado por ;). $2: Fichero destino.
# Salida: Escribe los logins generados en el fichero destino. No devuelve código de salida explícito.
# ============================================================

function f_generar_logins_universal() {

    origen="$1"
    destino="$2"

    >"$destino"

    while IFS=";" read nombre ap1 ap2 dni
    do
        iniciales=$(echo "$nombre" | awk '{for(i=1;i<=NF;i++) printf substr($i,1,1)}')

        apellido1=$(echo "$ap1" | cut -c1-3)
        apellido2=$(echo "$ap2" | cut -c1-3)

        ult_dni=$(echo "$dni" | tail -c 4)

        login=$(echo "$iniciales$apellido1$apellido2$ult_dni" | tr '[:upper:]' '[:lower:]')

        echo "$login" >> "$destino"

    done < "$origen"
}
