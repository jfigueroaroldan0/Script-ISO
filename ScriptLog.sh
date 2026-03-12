# ¡¡¡SE NECESITA SER SUDO !!!
# Registra un evento en un archivo de log cronologico.
# Autor: Abraham Begines Ruiz, Jose Manuel Lopéz Hueso, Jesús Figueroa Roldan, Ismael Cotán Rayas e Iván Jimenéz Moreno
# Entrada: El mensaje que queramos registrar.
# Salida: 0 si se ha registrado correctamente , 1 si da error.

f_log() {
echo "$(date '+%Y-%m-%d %H:%M:%S')  $1" >> "${2:-/var/log/sysadmin.log}"
}
