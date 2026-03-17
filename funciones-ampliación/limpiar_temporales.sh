#!/usr/bin/env bash
# Autor: Germán C.
# Descripción: Este script está diseñado para eliminar los ficheros de X directorio con más de Y días. Ambos parámetros se indican al empezar el script.
# Versión: 1

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

f_limpiar_temporales
