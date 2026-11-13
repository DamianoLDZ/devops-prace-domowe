# Configuration Manager (`konfiguracja.sh`)

## Opis

Skrypt `konfiguracja.sh` prezentuje mechanizm zarządzania konfiguracją z wykorzystaniem czterech warstw ustawień.

Pozwala odczytywać wartości z:
1. Wartości domyślnych zapisanych w skrypcie.
2. Pliku konfiguracyjnego.
3. Zmiennych środowiskowych.
4. Argumentów wiersza poleceń (CLI).

Każda kolejna warstwa ma wyższy priorytet i może nadpisać ustawienia pochodzące z wcześniejszych warstw.

## Wymagania

- Bash
- Linux

## Kolejność priorytetów

```text
1. DEFAULT
      |
      v
2. FILE
      |
      v
3. ENVIRONMENT
      |
      v
4. CLI
```

Najwyższy priorytet mają argumenty przekazane bezpośrednio podczas uruchamiania skryptu.

## Domyślna konfiguracja

Wartości początkowe:

| Parametr | Wartość |
|---|---|
| `THRESHOLD` | `85` |
| `VERBOSE` | `false` |

## Plik konfiguracyjny

Skrypt odczytuje konfigurację z:

```text
~/.config/konfiguracja.conf
```

Plik jest opcjonalny. Skrypt nie tworzy go automatycznie.

Aby przygotować konfigurację:

```bash
mkdir -p ~/.config
vim ~/.config/konfiguracja.conf
```

Przykładowa zawartość:

```ini
THRESHOLD=70
VERBOSE=true
```

Parser odczytuje pary klucz–wartość. Nie wykorzystuje polecenia `source`, dzięki czemu zawartość pliku jest traktowana jako dane, a nie wykonywany kod powłoki.

Obsługiwane klucze:
- `THRESHOLD`
- `VERBOSE`

## Zmienne środowiskowe

Skrypt obsługuje następujące zmienne:

| Zmienna | Opis |
|---|---|
| `DISK_THRESHOLD` | Ustawia próg |
| `DISK_VERBOSE` | Ustawia tryb szczegółowy |

Przykład:

```bash
export DISK_THRESHOLD=90
export DISK_VERBOSE=false
```

Uruchomienie:

```bash
./konfiguracja.sh --pokaz-konfiguracje
```

Zmienne środowiskowe nadpisują wartości pochodzące z pliku konfiguracyjnego.

## Dostępne opcje CLI

| Opcja | Opis |
|---|---|
| `-p PROCENT` | Ustawia próg |
| `-v` | Włącza tryb szczegółowy |
| `--pokaz-konfiguracje` | Wyświetla efektywne wartości i ich źródła |
| `-h` | Wyświetla pomoc |

## Przykłady

Ustawienie progu na 95%:

```bash
./konfiguracja.sh -p 95
```

Włączenie trybu szczegółowego:

```bash
./konfiguracja.sh -v
```

Wyświetlenie efektywnej konfiguracji:

```bash
./konfiguracja.sh --pokaz-konfiguracje
```

Połączenie kilku opcji:

```bash
./konfiguracja.sh -p 95 -v --pokaz-konfiguracje
```

## Przykładowy wynik

```text
Effective configuration:
THRESHOLD=95 (source: cli)
VERBOSE=true (source: cli)
```

Źródła wartości:
- `default` – wartość domyślna.
- `file` – plik konfiguracyjny.
- `environment` – zmienna środowiskowa.
- `cli` – argument wiersza poleceń.

Źródło jest określane niezależnie dla każdego parametru.

## Walidacja

Skrypt sprawdza poprawność konfiguracji.

`THRESHOLD`:
- musi być liczbą całkowitą,
- musi mieścić się w zakresie od 1 do 100.

`VERBOSE`:
- akceptuje wartości `true` lub `false`.

Nieprawidłowe wartości powodują wyświetlenie komunikatu błędu i zakończenie działania kodem `1`.

## Kontrola jakości

Sprawdzenie składni:

```bash
bash -n konfiguracja.sh
```

Analiza statyczna:

```bash
shellcheck konfiguracja.sh
```
