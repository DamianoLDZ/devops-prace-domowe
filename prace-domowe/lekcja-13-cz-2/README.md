# Lekcja 13 – część 2

## Temat lekcji

13. Bash/Shell. Część 2

## Treść pracy domowej

**Obowiązkowe:** (Wysyłamy w LMS jako link do repozytorium)

- Zadanie domowe nr 1
- [Opcjonalnie] Zadanie domowe nr 2
- Zadanie domowe nr 3

### Zadanie 1: Skrypt monitorujący miejsce na dysku

**Cel:** piszesz kompletny mały skrypt produkcyjny z opcjami, logiem i kodami wyjścia.

Napisz `dysk.sh [-p PROCENT] [-v] [-h]`, który sprawdza zajętość każdego zamontowanego systemu plików i loguje ostrzeżenie, gdy przekracza próg (domyślnie 85%). Kod wyjścia: 0 gdy wszystko poniżej progu, 1 gdy którykolwiek go przekracza.

**Kryterium ukończenia**

`./dysk.sh -p 1; echo $?` zwraca 1 i loguje co najmniej jeden system plików; `./dysk.sh -p 99; echo $?` zwraca 0; `shellcheck dysk.sh` bez uwag.

### Zadanie 3: Konfiguracja w trzech warstwach

**Cel:** rozumiesz i implementujesz kolejność priorytetów konfiguracji.


Rozbuduj dowolny swój skrypt tak, żeby czytał wartości z pliku `~/.config/NAZWA.conf` (parserem klucz–wartość, bez `source`), ze zmiennych środowiskowych i z opcji, w kolejności czterech warstw konfiguracji. Dodaj opcję `--pokaz-konfiguracje` wypisującą wartości efektywne wraz ze źródłem każdej z nich.

**Kryterium ukończenia**

Ta sama wartość ustawiona we wszystkich trzech miejscach jest raportowana jako pochodząca z wiersza poleceń; nieznany klucz w pliku daje ostrzeżenie, a nie błąd.

## Rozwiązanie

Do uzupełnienia.

## Wykorzystane narzędzia

Do uzupełnienia.
