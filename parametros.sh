#!/usr/bin/env bash

#Comprueba que se han introducido argumentos al script.
#Entrada: Argumento
#Salida: Mensaje de error si no hay argumento

function f_parametros() {
    if [ $# -eq 0 ]; then
        echo "Error: no se han introducido argumentos"
        exit 1
    fi
}

f_parametros "$@"

echo "Argumentos recibidos: $@"
