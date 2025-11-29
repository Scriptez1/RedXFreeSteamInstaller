# 🎮 RedX Game Library

**Moderne Steam-Spielbibliothek und -Manager**

![Version](https://img.shields.io/badge/version-v2.1-red)
![Language](https://img.shields.io/badge/language-Python-blue)
![Platform](https://img.shields.io/badge/platform-Windows-lightgrey)
![License](https://img.shields.io/badge/license-CPL-green)

<div align="center">
  <img src="https://github.com/user-attachments/assets/642c0a5c-47d0-4beb-adb9-cbed85031666" alt="RedX Game Library" width="800">

  **A modern, multi-language Steam game library manager with an elegant red-black theme**
</div>

## 📋 Inhaltsverzeichnis

- [Funktionen](#-funktionen)
- [Installation](#-installation)
- [Verwendung](#-verwendung)
- [Sprachunterstützung](#-sprachunterstützung)
- [Systemanforderungen](#-systemanforderungen)
- [Mitwirken](#-mitwirken)
- [Lizenz](#-lizenz)

## ✨ Funktionen

### 🎨 Moderne Benutzeroberfläche
- **Rot-Schwarzes Design**: Elegantes und modernes Aussehen
- **Responsive Design**: Passt sich verschiedenen Bildschirmgrößen an
- **Animierte Elemente**: Sanfte Übergänge und Effekte

### 🌍 Mehrsprachige Unterstützung
- 🇹🇷 **Türkisch** (Hauptsprache)
- 🇺🇸 **Englisch**
- 🇩🇪 **Deutsch**
- 🇷🇺 **Russisch**
- 🇯🇵 **Japanisch**

### 🎮 Spielverwaltung
- **Spielsuche**: Schnelles und effektives Suchsystem
- **Genre-Filterung**: Spiele nach Genres filtern
- **Installationsverfolgung**: Installierte Spiele anzeigen und verwalten
- **Steam-Integration**: Direkter Zugang zu Steam Store-Seiten

### 🔧 Erweiterte Funktionen
- **Automatische Updates**: Automatische Update-Prüfung über GitHub
- **Steam-Pfad-Erkennung**: Automatische Steam-Ordner-Erkennung
- **DLC-Unterstützung**: Spiel-DLCs verwalten
- **Fortschrittsverfolgung**: Download- und Installationsfortschritt

## 🚀 Installation

1. Laden Sie die neueste `RedXGameLibrary.exe` von [Releases](https://github.com/Scriptez1/RedXFreeSteamInstaller/releases/latest) herunter
2. Doppelklicken Sie auf `RedXGameLibrary.exe` zum Ausführen
3. Keine Installation erforderlich!

## 📖 Verwendung

### Erster Start
1. Der Steam-Pfad wird beim Öffnen der Anwendung automatisch erkannt
2. Falls nicht erkannt, wählen Sie den Steam-Ordner manuell aus
3. Legen Sie die Anzahl der Spiele fest, die pro Seite angezeigt werden sollen (empfohlen: 9)

### Spielsuche und Filterung
- **Suchfeld**: Nach Spielnamen suchen
- **Genre-Filter**: Genres aus dem rechten Panel auswählen zum Filtern
- **Filter anwenden**: Klicken Sie auf die Schaltfläche "Filter", um Ihre Auswahl anzuwenden

### Spielverwaltung
- **Spiel hinzufügen**: Klicken Sie auf die Schaltfläche "Hinzufügen" auf der Spielkarte
- **Spiel löschen**: Verwenden Sie die Schaltfläche "Löschen" für installierte Spiele
- **Auf Steam ansehen**: Öffnen Sie die Steam-Seite des Spiels

### Sprachwechsel
- Klicken Sie auf die Flaggensymbole im rechten Panel, um die Sprache zu ändern
- Die Anwendung startet nach dem Sprachwechsel automatisch neu

## 🌍 Sprachunterstützung

Die Anwendung unterstützt folgende Sprachen:

| Sprache | Code | Status |
|---------|------|--------|
| Türkisch | `tr` | ✅ Vollständige Unterstützung |
| Englisch | `en` | ✅ Vollständige Unterstützung |
| Deutsch | `de` | ✅ Vollständige Unterstützung |
| Russisch | `ru` | ✅ Vollständige Unterstützung |
| Japanisch | `ja` | ✅ Vollständige Unterstützung |

## 💻 Systemanforderungen

### Mindestanforderungen
- **Betriebssystem**: Windows 10 oder höher
- **RAM**: 4 GB
- **Speicher**: 100 MB freier Speicherplatz
- **Internet**: Aktive Verbindung erforderlich

### Empfohlene Anforderungen
- **Betriebssystem**: Windows 11
- **RAM**: 8 GB
- **Speicher**: 500 MB freier Speicherplatz
- **Internet**: Schnelle Verbindung

## 📁 Projektstruktur

```
RedXFreeSteamInstaller/
├── gui.py              # Haupt-GUI-Anwendung
├── index.py            # Spiel-Download und Verarbeitungsmodul
├── languages.py        # Mehrsprachige Unterstützung
├── config.py           # Konfigurationsdatei
├── changes.txt         # Änderungsprotokoll
└── resources/          # Ressourcendateien
    ├── icon.ico        # Anwendungssymbol
    ├── games.json      # Spieldatenbank
    ├── censored.png    # Zensurbild
    ├── redx.dll        # Steam-Plugin
    └── flags/          # Flaggenbilder
        ├── TRflag.png
        ├── ENflag.png
        ├── DEflag.png
        ├── RUflag.png
        └── JPflag.png
```

## 🤝 Mitwirken

1. **Fork** das Repository
2. Erstellen Sie einen **Feature-Branch** (`git checkout -b feature/AmazingFeature`)
3. **Committen** Sie Ihre Änderungen (`git commit -m 'Add some AmazingFeature'`)
4. **Pushen** Sie zum Branch (`git push origin feature/AmazingFeature`)
5. Öffnen Sie eine **Pull Request**

## 📝 Lizenz

Dieses Projekt ist unter der MIT-Lizenz lizenziert. Siehe die `LICENSE`-Datei für Details.

## 🔗 Links

- **GitHub**: [RedXFreeSteamInstaller](https://github.com/Scriptez1/RedXFreeSteamInstaller)
- **Releases**: [Neueste Versionen](https://github.com/Scriptez1/RedXFreeSteamInstaller/releases)
- **Issues**: [Probleme melden](https://github.com/Scriptez1/RedXFreeSteamInstaller/issues)

## ⚠️ Warnung

Diese Anwendung dient Bildungszwecken. Verwenden Sie sie in Übereinstimmung mit Steams Nutzungsbedingungen.

---


**RedX Game Library** - Moderner Steam-Spiel-Manager 🎮
