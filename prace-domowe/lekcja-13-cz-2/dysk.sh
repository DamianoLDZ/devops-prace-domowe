#!/bin/bash

# Default disk usage threshold / Domyslny prog zajetosci dysku
THRESHOLD=85

# Verbose mode / Tryb szczegolowy
VERBOSE=false

# Log file / Plik dziennika
LOG_FILE="disk.log"

# Exit code / Kod wyjscia
EXIT_CODE=0

# Parse command-line options / Parsowanie opcji wiersza polecen
while getopts ":p:vh" opt; do
    case "$opt" in
        p)
            THRESHOLD="$OPTARG"
            ;;
        v)
            VERBOSE=true
            ;;
        h)
            echo "Usage: $0 [-p PERCENT] [-v] [-h]"
            exit 0
            ;;
        *)
            echo "Invalid option. Use -h for help."
            exit 1
            ;;
    esac
done

# Validate threshold / Sprawdzenie poprawnosci progu
if ! [[ "$THRESHOLD" =~ ^[0-9]+$ ]] || (( THRESHOLD < 1 || THRESHOLD > 100 )); then
    echo "Error: threshold must be a number between 1 and 100."
    exit 1
fi

# Get disk usage information / Pobierz informacje o zajetosci dyskow
if ! DF_OUTPUT=$(df -P); then
    echo "Error: failed to read disk usage."
    exit 1
fi

# Check mounted filesystems / Sprawdzanie zamontowanych systemow plikow
while read -r filesystem _ _ _ capacity mountpoint; do
    usage=${capacity%\%}

    if [[ "$VERBOSE" == true ]]; then
        echo "INFO: Checking $filesystem ($mountpoint) - ${usage}% used"
    fi

    if (( usage > THRESHOLD )); then
        EXIT_CODE=2

        MESSAGE="WARNING: $filesystem is ${usage}% full ($mountpoint)"

        echo "$MESSAGE"
        echo "$(date '+%Y-%m-%d %H:%M:%S') $MESSAGE" >> "$LOG_FILE"
    fi

done < <(printf '%s\n' "$DF_OUTPUT" | tail -n +2)

# Return exit code / Zwroc kod wyjscia
exit "$EXIT_CODE"

