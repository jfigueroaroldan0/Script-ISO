#!/env/usr/bin bash

# Devuelve si el archivo está integro o no, mediante una comparación hash md5.
# Entrada: ruta del archivo, último hash md5 conocido de dicho archivo.
# Salida: muestra 0 en caso permanecer integro, o 1 en caso contrario.

f_verificar_hash() {
  hash=$(md5sum $1 | awk '{print $1}')

  if [ "$hash" = "$2" ]; then
    return 0
  else
    exit 1
  fi
}

f_verificar_hash $1 $2

