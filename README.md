# emsi_connect

Application Flutter EMSI Connect (TPs).

## Lancer l'app

```bash
# Chrome en mode debug (plus lent, avec hot reload)
flutter run -d chrome

# Chrome plus rapide (sans hot reload)
flutter run -d chrome --release

# Serveur web fixe → ouvre toi-même Chrome sur http://localhost:8080
flutter run -d web-server --web-hostname=localhost --web-port=8080

# Windows desktop (nécessite le Developer Mode Windows)
flutter run -d windows

# Voir les appareils disponibles
flutter devices
```

### Raccourcis pendant `flutter run`

| Touche | Action        |
|--------|---------------|
| `r`    | Hot reload    |
| `R`    | Hot restart   |
| `q`    | Quitter       |

## Notes

- En **debug**, Flutter web est normalement lent (outils de debug chargés).
- `flutter run -d chrome` ouvre Chrome avec le debug Flutter (pas toujours comme un onglet Chrome “classique”).
- Pour un Chrome normal : utilise `web-server` puis ouvre `http://localhost:8080`.

## Prérequis

- Flutter SDK installé
- Pour Windows desktop : activer le *Developer Mode* (`ms-settings:developers`) pour le support des symlinks
