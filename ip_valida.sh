#!/usr/bin/env bash

# Autor: Jesús Figueroa Roldán
# Version: 1.0
# Descripcion:
# Fecha de creacion: 2026-03-12

# Descripción: Valida sintácticamente si una cadena tiene formato de IPv4.
# Entrada: $1: Cadena de texto a validar.
# Devuelve:
# 0: Formato de IP correcto.
# 1: Formato inválido (imprime error por stderr).

f_es_ip_valida() {

    echo "$1" | grep -E '^([0-9]{1,3}\.){3}[0-9]{1,3}$' >/dev/null

    if [ $? -eq 0 ]; then
        return 0
    else
        echo "Error: formato IPv4 inválido" >&2
        return 1
    fi

}

f_es_ip_valida $1
