#!/usr/bin/env bash

# Muestra los 10 comandos más utilizados en la shell actual
# Datos de entrada: no acepta
# Datos de salida: 10 comandos más usados
# No funciona en la shell sh

f_ranking_comandos() {

  history | awk '{print $2}' | sort | uniq -c | sort -rn | head -10
  return 0
}

f_ranking_comandos
