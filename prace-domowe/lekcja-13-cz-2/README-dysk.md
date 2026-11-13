# Disk Monitor (`dysk.sh`)

## Opis

Skrypt `dysk.sh` służy do monitorowania zajętości zamontowanych systemów plików w systemie Linux.

Sprawdza wykorzystanie przestrzeni dyskowej i wyświetla ostrzeżenie, gdy zajętość przekracza określony próg. Ostrzeżenia są dodatkowo zapisywane w pliku `disk.log`.

## Wymagania

- Bash
- Narzędzie `df`
- Uprawnienia do zapisu w katalogu, w którym uruchamiany jest skrypt

## Uruchomienie

```bash
./dysk.sh
```

Domyślny próg zajętości wynosi 85%.

## Dostępne opcje

| Opcja | Opis |
|---|---|
| `-p PROCENT` | Ustawia własny próg zajętości dysku |
| `-v` | Włącza tryb szczegółowy |
| `-h` | Wyświetla pomoc |

## Przykłady

Sprawdzenie zajętości z domyślnym progiem:

```bash
./dysk.sh
```

Ustawienie progu na 90%:

```bash
./dysk.sh -p 90
```

Uruchomienie w trybie szczegółowym:

```bash
./dysk.sh -v
```

Połączenie kilku opcji:

```bash
./dysk.sh -p 80 -v
```

Wyświetlenie pomocy:

```bash
./dysk.sh -h
```

## Logowanie

Ostrzeżenia są zapisywane w pliku `disk.log`.

Każdy wpis zawiera datę, godzinę, nazwę systemu plików oraz jego punkt montowania.

Przykładowy wpis:

```text
2026-11-13 12:30:00 WARNING: /dev/sdb is 100% full (/usr)
```

## Kody wyjścia

| Kod | Znaczenie |
|---|---|
| `0` | Żaden system plików nie przekroczył ustawionego progu |
| `1` | Błędne argumenty, nieprawidłowy próg lub błąd odczytu danych |
| `2` | Co najmniej jeden system plików przekroczył próg |

Sprawdzenie kodu wyjścia:

```bash
./dysk.sh -p 85
echo $?
```

## Walidacja

Skrypt sprawdza poprawność podanego progu. Akceptowane są wyłącznie liczby całkowite z zakresu od 1 do 100.

Nieprawidłowa wartość powoduje wyświetlenie komunikatu błędu i zakończenie działania.

## Kontrola jakości

Składnię można sprawdzić poleceniem:

```bash
bash -n dysk.sh
```

Do analizy statycznej służy ShellCheck:

```bash
shellcheck dysk.sh
```
