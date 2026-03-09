# Función que devuelve 0 si se está ejecutando como root
# Datos de entrada: no acepta
# Datos de salida: 0 si es root

f_uid() {

uid=$(id -u)

  if [ "$uid" -eq 0 ]; then
    return $uid

  else
    echo "No puede continuar la ejecución del script porque no eres root"
    return $uid
  fi
}

f_uid
