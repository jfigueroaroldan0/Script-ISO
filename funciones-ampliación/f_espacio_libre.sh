#Descripción: te muestra si hay espacio disponible en el punto de montaje
#Entradas: El punto de montaje y la cantidad minima de espacio en porcentaje
#Slida: 0 si hay espacio, 1 si no hay o no existe el punto de montaje


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

f_espacio_libre "$1" "$2"

