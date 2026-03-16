#!/usr/bin/env bash


# Descripción: Muestra los comandos más utilizados
# Entrada: no admite
# Salida: top 10 comandos que más se han utilizado

rojo='\033[31m'
verde='\033[32m'
amarillo='\033[33m'
azul='\033[34m'
magenta='\033[35m'
cian='\033[36m'
blanco='\033[37m'
reset='\033[0m'
negrita='\033[1m'


function f_ranking_comandos() {

cat ~/.bash_history | sort | uniq -c | sort -rn | head -10


}

f_ranking_comandos
