#!/usr/bin/env bash

read -p "Introduce el nombre del script a crear: " filename

autor=""
version="1.0"
descripcion=""
fecha=$(date +"%Y-%m-%d")

cat <<EOF > "$filename"

#!/usr/bin/env bash

# Autor: $autor
# Version: $version
# Descripcion: $descripcion
# Fecha de creacion: $fecha

EOF

chmod +x "$filename"

echo "Script '$filename' creado correctamente."
