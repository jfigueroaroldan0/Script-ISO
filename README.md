Crea las siguientes funciones para shell script

# f_ranking_comandos

Indica los 10 comandos más utilizados en la shell

# f_uid

Indica el uid del usuario actual de la shell

# f_ayuda

Muestra por pantalla la sintaxis correcta del script, descripción de lo que hace el script así como los parámetros aceptados.

# f_parametros

Comprueba que se han introducido argumentos al script.

# f_bin_instalado

Función que devuelve cero en caso de estar instalado el binario que se pasa como argumento.y uno en caso contrario,

# f_hay_conexion

Devuelve cero en caso de tener conexión a red, uno en caso contrario.

# f_eres_root

Devuelve cero en caso de estar validado en la shell como root, uno en caso contrario.

# f_paquete_disponible

Devuelve cero en caso de estar disponible en el repositorio configurado en sources.list, uno en caso contrario. Se pasa el nombre del paquete como argumento.

# f_paquete_instalado

Devuelve cero en caso de estar instalado el paquete pasado como argumento, uno en caso contrario.

f_buscar_paquetes

Devuelve el nombre del paquete al que pertenece el binario que se pasa como argumento.

# Funciones ampliación

# f_espacio_libre
Descripción: Comprueba si un punto de montaje tiene suficiente espacio libre.
Entrada: 
  $1: Punto de montaje (ej: /var, /home).
  $2: Porcentaje mínimo requerido (ej: 10 para 10%).
Devuelve: 
  0: Hay espacio suficiente.
  1: Espacio insuficiente o punto de montaje no encontrado.

# f_puerto_abierto
Descripción: Verifica si un servicio está escuchando en un puerto específico.
Entrada: 
  $1: Dirección IP o Hostname.
  $2: Número de puerto.
Devuelve: 
  0: El puerto está abierto y responde.
  1: El puerto está cerrado o es inalcanzable.

# f_es_ip_valida 
Descripción: Valida sintácticamente si una cadena tiene formato de IPv4.
Entrada: $1: Cadena de texto a validar.
Devuelve: 
0: Formato de IP correcto.
1: Formato inválido (imprime error por stderr).

# f_log
Descripción: Registra un evento en un archivo de log cronológico.
Entrada: 
  $1: Mensaje de texto a registrar.
  $2: (Opcional) Ruta del archivo de log. Por defecto /var/log/sysadmin.log.
Devuelve: 
  0: Registro guardado correctamente.
  1: Error de permisos al escribir en el archivo.

# f_verificar_hash
Descripción: Compara la integridad de un archivo contra un hash MD5.
Entrada: 
  $1: Ruta del archivo.
  $2: Cadena del hash esperado.
Devuelve: 
  0: Los hashes coinciden, archivo íntegro.
  1: Los hashes no coinciden o el archivo no existe.

# f_limpiar_temporales
Descripción: Borra archivos antiguos en un directorio específico.
Entrada: 
  $1: Ruta del directorio.
  $2: Antigüedad en días (ej: 7 para borrar archivos de más de una semana).
Devuelve: 
  0: Limpieza realizada.
  1: Directorio no encontrado.

# f_borrar_duplicados
Descripción: Identifica y elimina archivos duplicados en un directorio basado 
             en su hash (contenido) y opcionalmente por patrón de nombre.
Entrada: 
  $1: Ruta del directorio a analizar (ej: /home/usuario/Descargas).
  $2: Modo (CHECK para solo listar, DELETE para borrar).
Devuelve: 
  0: Proceso finalizado con éxito.
  1: El directorio no existe o no hay permisos.

# f_generar_logins_universal 
Descripción: Genera identificadores en minúsculas procesando nombres y apellidos. Compatible con /bin/sh y /bin/bash. Ejemplo de entrada: Francisco Javier;de la Vega;López Cobos;12345678Z
	Nombre: Todas las iniciales. Francisco Javier ->fj
	Apellidos: 3 primeras letras (sin espacios). de la Vega; López Cobos ->dellop 
	DNI: 3 últimos caracteres. 78z
Valores de entrada:  $1: Fichero origen (CSV delimitado por ;).  $2: Fichero destino.
