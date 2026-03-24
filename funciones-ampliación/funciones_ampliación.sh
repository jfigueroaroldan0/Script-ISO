#!/usr/bin/env bash

# ============================================================
# Librería de funciones de administración de sistemas
# Autores:
#   - Abraham Begines Ruiz
#   - Jose Manuel López Hueso
#   - Jesús Figueroa Roldán
#   - Ismael Cotán Rayas
#   - Iván Jiménez Moreno
#   - Germán C.
# Versión: 1.0
# Fecha de creación: 2026-03-12
# ============================================================


# ============================================================
# f_espacio_libre
# Descripción: te muestra si hay espacio disponible en el punto de montaje
# Entradas: El punto de montaje y la cantidad minima de espacio en porcentaje
# Salida: 0 si hay espacio, 1 si no hay o no existe el punto de montaje
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
# Registra un evento en un archivo de log cronologico.
# Entrada: El mensaje que queramos registrar.
# Salida: 0 si se ha registrado correctamente , 1 si da error.
# ¡¡¡SE NECESITA SER SUDO !!!
# ============================================================

f_log() {
echo "$(date '+%Y-%m-%d %H:%M:%S')  $1" >> "${2:-/var/log/sysadmin.log}"
}


# ============================================================
# f_verificar_hash
# Devuelve si el archivo está integro o no, mediante una comparación hash md5.
# Entrada: ruta del archivo, último hash md5 conocido de dicho archivo.
# Salida: muestra 0 en caso permanecer integro, o 1 en caso contrario.
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
# Descripción: Verifica si un servicio está escuchando en un puerto específico
# Entrada: Dirección IP o Hostname ($1) y Número de puerto ($2).
# Salida: Puerto está abierto y responde (0) o el puerto está cerrado o es inalcanzable (1).
# ============================================================

function f_puerto_abierto() {
    timeout 2 bash -c "echo > /dev/tcp/$1/$2" >/dev/null 2>&1 && return 0 || return 1
}


# ============================================================
# f_es_ip_valida
# Descripción: Valida sintácticamente si una cadena tiene formato de IPv4.
# Entrada: $1: Cadena de texto a validar.
# Devuelve:
# 0: Formato de IP correcto.
# 1: Formato inválido (imprime error por stderr).
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
# Descripción: Este script está diseñado para eliminar los ficheros de X directorio con más de Y días. Ambos parámetros se indican al empezar el script.
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
# Descripción: Genera identificadores en minúsculas procesando nombres y apellidos. Compatible con /bin/sh
# Entrada: $1: Fichero origen (CSV delimitado por ;).  $2: Fichero destino
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
