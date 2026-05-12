#!/bin/bash
manual() {
    cat << EOF
INSTRUKCJA GRY: WISIELEC 

OPIS:

    Gra polega na odgadnięciu słowa litera po literze zanim 
    zawiśnie wisielec! Liczba prób jest ograniczona.

OPCJE:

    -h    Wyświetla tę pomoc (manual)
    -v    Wyświetla wersję programu

KONFIGURACJA:

    W pliku konfiguracje.txt możesz ustawić parametry gry,
    ustawić wielkość słowa i ilość prób.

EOF
}

# Obsługa flag
while getopts "hv" opcja; do
    case "$opcja" in
        h)
            manual
            exit 0
            ;;
        v)
            echo "Wisielec v4.20 (Build 2026)"
            exit 0
            ;;
        
    esac
done