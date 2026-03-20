f_borrar_duplicados() {
    dir="$1"
    modo="$2"

    if [[ ! -d "$dir" ]]; then
        echo "Error: directorio no existe."
        return 1
    fi

    tmp=$(mktemp)

    find "$dir" -type f | while read file; do
        hash=$(sha256sum "$file" | awk '{print $1}')
        if grep -q "$hash" "$tmp"; then
            if [[ "$modo" == "CHECK" ]]; then
                echo "Duplicado: $file"
            elif [[ "$modo" == "DELETE" ]]; then
                rm "$file"
                echo "Eliminado: $file"
            fi
        else
            echo "$hash" >> "$tmp"
        fi
    done

    rm "$tmp"
    return 0
}
f_borrar_duplicados $1 $2
