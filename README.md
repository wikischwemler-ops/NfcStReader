# NfcStReader

PC-Software und STM32-Firmware für das ST-Board **MB1054A** (STM32F103CB + CR95HF)
zum Lesen und Beschreiben von NFC-Tags.

Das Projekt liegt im Ordner [`nfc-cr95hf/`](nfc-cr95hf/README.md):

- `firmware/` – STM32F103CB als USB-CDC-zu-SPI-Brücke zum CR95HF (libopencm3).
- `pc/` – .NET-WinForms-Programm: Tag lesen, anzeigen, bearbeiten, zurückschreiben, klonen.

## Branch-Benennung

Neue Branches zweistufig `präfix/name` (klein), siehe [docs/branch-naming-setup.md](docs/branch-naming-setup.md).
Nach dem Klonen einmalig `git config core.hooksPath .githooks` ausführen (oder `tools/git_hooks_einrichten.bat`).
