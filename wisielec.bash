#!/bin/bash


source ./grafika.bash

{
    read -r NAGLOWEK
    read -r DLUGOSC_HASLA
    read -r NAGLOWEK
    read -r ILOSC_PROB
} < konfiguracje.txt

HASLO=$(shuf -n 1 /usr/share/dict/polish | tr '[:upper:]' '[:lower:]')

while [[ ${#HASLO} -gt "$DLUGOSC_HASLA" ]]; do
    HASLO=$(shuf -n 1 /usr/share/dict/polish | tr '[:upper:]' '[:lower:]')
done

HASLO=${HASLO,,}

HASLO_TAB=( $(echo $HASLO | sed 's/./& /g') )

WIDOK=( $(echo $HASLO | sed 's/./  ____  /g') )
nr=0
licznik=0
ODPADNIETE=()
while true; do
    ((pozostale_proby=$ILOSC_PROB-$nr))
    TEKST_ODPADY="${ODPADNIETE[*]}"
    LITERA=$(zenity --entry \
        --title="Wisielec" \
        --width=400 --height=500 \
        --text="Pozostałe próby: $pozostale_proby\n\n${Etapy[$nr]}\n\n\n\nSłowo: ${WIDOK[*]}\n\n\n\nBrak: $TEKST_ODPADY\n\n\nPodaj literę:" \
        )

    if [ $? -ne 0 ]; then
        echo "Gracz kliknął Anuluj. Wyjście."
        break
    fi
    LITERA=${LITERA,,}
    for i in "${!HASLO_TAB[@]}"; do
        if [[ "${HASLO_TAB[$i]}" == "$LITERA" ]]; then
            WIDOK[$i]="$LITERA"
            ((licznik++))
        fi
    done

    if [[ ! " ${ODPADNIETE[*]} " =~ " $LITERA " && "$licznik" == 0 ]]; then
        ODPADNIETE+=("$LITERA")
    fi

    if (( "$nr" != "$ILOSC_PROB" && "$licznik" == 0 )); then
        ((nr++))
        
    fi
    licznik=0

    if [[ "${WIDOK[*]}" != *"____"* ]]; then
        zenity --info --text="\nWYGRANA!             \nHasło: $HASLO"
        break
    fi
    if (( nr >= 9 )); then
        zenity --error --text="\nPRZEGRANA! \nNieodgatnięte hasło: $HASLO"
        break
    fi
done