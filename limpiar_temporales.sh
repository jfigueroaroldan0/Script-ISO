f_limpiar_temporales() {

  find $1 -type f -mtime 0 2>/dev/null | xargs rm 

  if [ $? -eq 0 ]; then
    return 0
  else
    exit 1
  fi
}

f_limpiar_temporales $1
