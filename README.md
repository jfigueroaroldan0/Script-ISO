# Funciones del Script


---

## Funciones principales

### **f_ranking_comandos**
**Descripción:**  
Indica los 10 comandos más utilizados en la shell actual.

---

### **f_uid**
**Descripción:**  
Indica el UID del usuario actual de la shell.

---

### **f_ayuda**
**Descripción:**  
Muestra por pantalla la sintaxis correcta del script, una breve descripción de su función y los parámetros aceptados.

---

### **f_parametros**
**Descripción:**  
Comprueba que se han introducido argumentos al script.

---

### **f_bin_instalado**
**Descripción:**  
Verifica si el binario pasado como argumento está instalado.  
**Devuelve:**  
- `0` → Instalado  
- `1` → No instalado

---

### **f_hay_conexion**
**Descripción:**  
Comprueba si hay conexión a red.  
**Devuelve:**  
- `0` → Hay conexión  
- `1` → No hay conexión

---

### **f_eres_root**
**Descripción:**  
Verifica si el usuario actual tiene privilegios de root.  
**Devuelve:**  
- `0` → Es root  
- `1` → No es root

---

### **f_paquete_disponible**
**Descripción:**  
Comprueba si un paquete está disponible en los repositorios configurados en `sources.list`.  
**Entrada:** Nombre del paquete.  
**Devuelve:**  
- `0` → Disponible  
- `1` → No disponible

---

### **f_paquete_instalado**
**Descripción:**  
Verifica si un paquete está instalado.  
**Entrada:** Nombre del paquete.  
**Devuelve:**  
- `0` → Instalado  
- `1` → No instalado

---

### **f_buscar_paquetes**
**Descripción:**  
Devuelve el nombre del paquete al que pertenece un binario pasado como argumento.

---

## Funciones de ampliación

### **f_espacio_libre**
**Descripción:**  
Comprueba si un punto de montaje tiene suficiente espacio libre.  
**Entradas:**  
- `$1`: Punto de montaje (ej: `/var`, `/home`)  
- `$2`: Porcentaje mínimo requerido (ej: `10` para 10%)  
**Devuelve:**  
- `0` → Hay espacio suficiente  
- `1` → Espacio insuficiente o punto de montaje no encontrado

---

### **f_puerto_abierto**
**Descripción:**  
Verifica si un servicio está escuchando en un puerto específico.  
**Entradas:**  
- `$1`: Dirección IP o Hostname  
- `$2`: Número de puerto  
**Devuelve:**  
- `0` → El puerto está abierto  
- `1` → El puerto está cerrado o inalcanzable

---

### **f_es_ip_valida**
**Descripción:**  
Valida si una cadena tiene formato de dirección IPv4 válida.  
**Entrada:**  
- `$1`: Cadena a validar  
**Devuelve:**  
- `0` → Formato válido  
- `1` → Formato inválido (imprime error por `stderr`)

---

### **f_log**
**Descripción:**  
Registra un evento en un archivo de log cronológico.  
**Entradas:**  
- `$1`: Mensaje de texto a registrar  
- `$2` *(opcional)*: Ruta del archivo de log (por defecto `/var/log/sysadmin.log`)  
**Devuelve:**  
- `0` → Registro guardado correctamente  
- `1` → Error de permisos o escritura

---

### **f_verificar_hash**
**Descripción:**  
Compara la integridad de un archivo contra un hash MD5 esperado.  
**Entradas:**  
- `$1`: Ruta del archivo  
- `$2`: Cadena del hash esperado  
**Devuelve:**  
- `0` → Coinciden  
- `1` → No coinciden o el archivo no existe

---

### **f_limpiar_temporales**
**Descripción:**  
Elimina archivos antiguos en un directorio específico.  
**Entradas:**  
- `$1`: Ruta del directorio  
- `$2`: Antigüedad en días (ej: `7` → archivos de más de una semana)  
**Devuelve:**  
- `0` → Limpieza realizada  
- `1` → Directorio no encontrado

---

### **f_borrar_duplicados**
**Descripción:**  
Identifica y elimina archivos duplicados en un directorio basándose en su hash o nombre.  
**Entradas:**  
- `$1`: Ruta del directorio a analizar (ej: `/home/usuario/Descargas`)  
- `$2`: Modo (`CHECK` → solo lista, `DELETE` → elimina duplicados)  
**Devuelve:**  
- `0` → Proceso exitoso  
- `1` → Directorio inexistente o sin permisos

---

### **f_generar_logins_universal**
**Descripción:**  
Genera identificadores de usuario a partir de nombres y apellidos (compatible con `/bin/sh` y `/bin/bash`).  
**Ejemplo de entrada:**  
`Francisco Javier;de la Vega;López Cobos;12345678Z`  
**Resultado:**  
- Nombre: iniciales → `fj`  
- Apellidos: tres primeras letras (sin espacios) → `dellop`  
- DNI: tres últimos caracteres → `78z`  
**Entradas:**  
- `$1`: Fichero origen CSV (delimitado por `;`)  
- `$2`: Fichero destino
