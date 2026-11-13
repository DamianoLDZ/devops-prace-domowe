#!/bin/bash

# Default configuration / Domyslna konfiguracja
THRESHOLD=85
VERBOSE=false

# Configuration sources / Zrodla konfiguracji
THRESHOLD_SOURCE="default"
VERBOSE_SOURCE="default"

# Load configuration file / Wczytanie pliku konfiguracyjnego
CONFIG_FILE="$HOME/.config/konfiguracja.conf"

if [[ -f "$CONFIG_FILE" ]]; then
    while IFS='=' read -r key value; do
        # Skip empty lines and comments / Pomijanie pustych linii i komentarzy
        [[ -z "$key" || "$key" == \#* ]] && continue

        case "$key" in
            THRESHOLD)
                THRESHOLD="$value"
                THRESHOLD_SOURCE="file"
                ;;
            VERBOSE)
                VERBOSE="$value"
                VERBOSE_SOURCE="file"
                ;;
        esac
    done < "$CONFIG_FILE"
fi

# Load environment variables / Wczytanie zmiennych srodowiskowych
if [[ -n "${DISK_THRESHOLD+x}" ]]; then
    THRESHOLD="$DISK_THRESHOLD"
    THRESHOLD_SOURCE="environment"
fi

if [[ -n "${DISK_VERBOSE+x}" ]]; then
    VERBOSE="$DISK_VERBOSE"
    VERBOSE_SOURCE="environment"
fi

# Parse command-line arguments / Parsowanie argumentow CLI
SHOW_CONFIG=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -p)
            if [[ $# -lt 2 ]]; then
                echo "Error: -p requires a value."
                exit 1
            fi
            THRESHOLD="$2"
            THRESHOLD_SOURCE="cli"
            shift 2
            ;;
        -v)
            VERBOSE=true
            VERBOSE_SOURCE="cli"
            shift
            ;;
        --pokaz-konfiguracje)
            SHOW_CONFIG=true
            shift
            ;;
        -h)
            echo "Usage: $0 [-p PERCENT] [-v] [--pokaz-konfiguracje] [-h]"
            exit 0
            ;;
        *)
            echo "Error: unknown option: $1"
            exit 1
            ;;
    esac
done

# Validate configuration / Walidacja konfiguracji
if ! [[ "$THRESHOLD" =~ ^[0-9]+$ ]]; then
    echo "Error: THRESHOLD must be a number between 1 and 100."
    exit 1
fi

THRESHOLD_NUM=$((10#$THRESHOLD))

if (( THRESHOLD_NUM < 1 || THRESHOLD_NUM > 100 )); then
    echo "Error: THRESHOLD must be a number between 1 and 100."
    exit 1
fi

if [[ "$VERBOSE" != "true" && "$VERBOSE" != "false" ]]; then
    echo "Error: VERBOSE must be true or false."
    exit 1
fi

# Display effective configuration / Wyswietlenie efektywnej konfiguracji
if [[ "$SHOW_CONFIG" == true ]]; then
    echo "Effective configuration:"
    echo "THRESHOLD=$THRESHOLD (source: $THRESHOLD_SOURCE)"
    echo "VERBOSE=$VERBOSE (source: $VERBOSE_SOURCE)"
fi
