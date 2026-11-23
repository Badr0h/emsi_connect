# EMSI Connect

Application Flutter réalisée dans le cadre des **travaux pratiques EMSI**.  
Espace universitaire : accueil, cours, profil, formulaires (login / inscription), paramètres et multimédia.

**Repo :** https://github.com/Badr0h/emsi_connect

---

## Prérequis

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installé (`flutter doctor` OK)
- Chrome (recommandé pour tester sur Windows)
- Pour **Windows desktop** : activer le *Developer Mode*  
  → `ms-settings:developers` (nécessaire pour les symlinks / plugins)

---

## Lancer l'app

```bash
# 1) Installer les dépendances (première fois ou après un pull)
flutter pub get

# 2) Voir les appareils disponibles
flutter devices

# 3a) Chrome — mode debug (hot reload, plus lent)
flutter run -d chrome

# 3b) Chrome — mode release (plus rapide, sans hot reload)
flutter run -d chrome --release

# 3c) Serveur web fixe → ouvre Chrome toi-même sur http://localhost:8080
flutter run -d web-server --web-hostname=localhost --web-port=8080

# 3d) Windows desktop (Developer Mode requis)
flutter run -d windows
```

### Raccourcis pendant `flutter run`

| Touche | Action                                      |
|--------|---------------------------------------------|
| `r`    | Hot reload (recharge le code sans tout relancer) |
| `R`    | Hot restart (redémarre l’app)               |
| `q`    | Quitter                                     |

### Important à savoir sur Chrome

- `flutter run -d chrome` ouvre Chrome en **mode debug Flutter** (port aléatoire, outils liés). Ce n’est pas toujours un onglet Chrome “classique”.
- Pour un **Chrome normal** : utilise `web-server` puis ouvre `http://localhost:8080`.
- En **debug**, l’app web est **normalement lente**. Pour la fluidité : `--release`.
- Si tu vois `ERR_CONNECTION_REFUSED` : l’app n’est plus lancée (session terminée). Relance avec `flutter run`.
- Brave / un autre navigateur ne reçoit pas automatiquement le serveur Flutter : utilise `web-server` + l’URL affichée.

---

## Structure du projet

```
emsi_connect/
├── lib/
│   ├── main.dart                 # Point d’entrée + thèmes clair/sombre
│   ├── utils/
│   │   └── validators.dart       # Validation email, mdp, téléphone, champs requis
│   └── screens/
│       ├── home_page.dart        # Accueil (grille + drawer)
│       ├── courses_page.dart     # Liste des modules (ListView)
│       ├── profile_page.dart     # Profil étudiant
│       ├── student_details_page.dart
│       ├── login_page.dart       # Connexion (formulaire)
│       ├── register_page.dart    # Inscription (formulaire)
│       ├── multimedia_page.dart  # Caméra / galerie / audio
│       ├── settings_page.dart    # Paramètres (switches)
│       └── about_page.dart       # À propos
├── assets/images/emsi.png        # Logo
├── android/  web/  windows/      # Plateformes supportées
├── reponses_tp3.txt              # Réponses écrites TP3
├── reponses_tp4.txt              # Réponses écrites TP4
├── pubspec.yaml                  # Dépendances
└── README.md
```

Plateformes **retirées** (inutiles sur Windows pour ce TP) : `ios/`, `linux/`, `macos/`.

---

## Pages de l’application

| Page | Rôle |
|------|------|
| **HomePage** | Accueil, logo, grille de catégories, menu latéral (drawer) |
| **CoursesPage** | Modules en `ListView.builder` + `Card` / `ListTile` + SnackBar |
| **ProfilePage** | Infos étudiant, modifier le nom, carte étudiant, détails |
| **StudentDetailsPage** | Affiche nom + filière reçus en paramètres |
| **LoginPage** | Formulaire email / mot de passe + validation |
| **RegisterPage** | Inscription complète (nom, email, mdp, tel, description) |
| **MultimediaPage** | Image (caméra/galerie) + enregistrement / lecture audio |
| **SettingsPage** | Notifications, mode compact, infos complémentaires |
| **AboutPage** | Texte descriptif du projet |

Navigation principale : **Drawer** sur l’accueil + cartes de la grille.

---

## Mots-clés Flutter à connaître absolument

### Bases

| Mot-clé | À savoir |
|---------|----------|
| **Widget** | Tout élément d’UI (bouton, texte, page…). En Flutter, “tout est un widget”. |
| **child** | **Un seul** widget enfant. Ex. : `Center(child: Text('…'))`, `Padding(child: …)`. |
| **children** | **Plusieurs** widgets enfants (une liste). Ex. : `Column(children: […])`, `Row(children: […])`. |
| **StatelessWidget** | Widget **sans état** : l’affichage ne change pas tout seul. Ex. : `HomePage`, `AboutPage`. |
| **StatefulWidget** | Widget **avec état** : peut se mettre à jour (`setState`). Ex. : `LoginPage`, `SettingsPage`. |
| **State** | Objet qui garde les données d’un `StatefulWidget` et reconstruit l’UI. |
| **build()** | Méthode qui **construit** l’interface à afficher. |
| **setState()** | Dit à Flutter : “les données ont changé, reconstruis l’UI”. |
| **const** | Widget / valeur fixe → Flutter peut optimiser (moins de rebuilds). |
| **context** | Lien vers la position du widget dans l’arbre (thème, navigation, SnackBar…). |
| **mounted** | `true` si le widget est encore à l’écran. À vérifier après un `await`. |
| **dispose()** | Libère les ressources (`TextEditingController`, audio…). Obligatoire pour éviter les fuites. |

### Mise en page

| Mot-clé | À savoir |
|---------|----------|
| **Scaffold** | Structure de page : AppBar, body, drawer, FAB… |
| **AppBar** | Barre du haut (titre, actions). |
| **SafeArea** | Évite les zones système (encoche, barre de statut). |
| **Padding** / **EdgeInsets** | Marges intérieures. |
| **SizedBox** | Espace fixe (largeur / hauteur) ou widget de taille fixe. |
| **Column** | Empile les widgets **verticalement**. |
| **Row** | Aligne les widgets **horizontalement**. |
| **Expanded** | Prend tout l’espace restant dans une Row/Column. |
| **Flexible** | Comme Expanded, mais plus souple (peut ne pas tout prendre). |
| **Center** | Centre un enfant. |
| **Container** | Boîte avec couleur, padding, bordure, taille… |
| **Stack** | Superpose des widgets (ex. : bannière + avatar). |
| **Positioned** | Place un enfant dans un `Stack`. |
| **SingleChildScrollView** | Rend le contenu **défilable** (utile avec le clavier). |
| **ConstrainedBox** | Limite min/max (ex. : `maxWidth: 420` pour un formulaire). |
| **LayoutBuilder** | Adapte l’UI selon la largeur disponible (mobile / tablette). |
| **Align** / **crossAxisAlignment** / **mainAxisAlignment** | Alignement dans Row/Column. |

### Listes & grilles

| Mot-clé | À savoir |
|---------|----------|
| **ListView** | Liste défilante. |
| **ListView.builder** | Liste **performante** : construit seulement les éléments visibles. |
| **itemCount** | Nombre d’éléments dans le builder. |
| **itemBuilder** | Fonction qui crée le widget de chaque ligne. |
| **GridView** / **GridView.count** | Grille (ex. : cartes de l’accueil). |
| **Card** | Conteneur avec ombre / relief. |
| **ListTile** | Ligne standard : icône, titre, sous-titre, trailing, `onTap`. |
| **shrinkWrap** | La liste prend seulement la hauteur de son contenu (dans une Column). |
| **NeverScrollableScrollPhysics** | Désactive le scroll interne (le parent scroll déjà). |

### Navigation

| Mot-clé | À savoir |
|---------|----------|
| **Navigator** | Gère la pile des pages (écran précédent / suivant). |
| **push** | Ouvre une nouvelle page. |
| **pop** | Ferme la page actuelle (retour). |
| **pushReplacement** | Remplace la page actuelle (ex. : login → home). |
| **pushAndRemoveUntil** | Ouvre une page et vide la pile (ex. : déconnexion → login). |
| **MaterialPageRoute** | Route Material classique pour naviguer. |
| **Drawer** | Menu latéral. |
| **FloatingActionButton (FAB)** | Bouton flottant. |

### Formulaires & saisie

| Mot-clé | À savoir |
|---------|----------|
| **Form** | Regroupe les champs à valider ensemble. |
| **GlobalKey\<FormState\>** | Clé pour appeler `validate()` sur tout le formulaire. |
| **TextFormField** | Champ de texte avec validation intégrée. |
| **TextField** | Champ de texte simple (souvent dans un dialog). |
| **TextEditingController** | Lit / écrit / contrôle le texte d’un champ. |
| **validator** | Fonction : retourne un `String` d’erreur ou `null` si OK. |
| **obscureText** | Masque le mot de passe. |
| **keyboardType** | Type de clavier (`emailAddress`, `phone`…). |
| **textInputAction** | Action du bouton clavier (`next`, `done`…). |
| **InputDecoration** | Label, hint, icônes, bordures du champ. |
| **prefixIcon** / **suffixIcon** | Icônes à gauche / droite du champ. |

### Feedback & dialogue

| Mot-clé | À savoir |
|---------|----------|
| **SnackBar** | Petit message temporaire en bas de l’écran. |
| **ScaffoldMessenger** | Affiche le SnackBar correctement. |
| **AlertDialog** | Boîte de dialogue (ex. : modifier le nom). |
| **showDialog** | Ouvre une boîte de dialogue et peut retourner une valeur. |
| **InkWell** / **GestureDetector** | Détecte les clics / gestes. |
| **IconButton** | Bouton icône. |
| **FilledButton** / **ElevatedButton** / **OutlinedButton** / **TextButton** | Types de boutons Material. |

### Thème & Material

| Mot-clé | À savoir |
|---------|----------|
| **MaterialApp** | Racine de l’app Material (thème, home, routes…). |
| **ThemeData** | Style global (couleurs, inputs…). |
| **ColorScheme.fromSeed** | Génère une palette à partir d’une couleur. |
| **useMaterial3** | Active Material Design 3. |
| **theme** / **darkTheme** | Thème clair / sombre. |
| **Theme.of(context)** | Récupère le thème courant. |
| **Image.asset** | Affiche une image déclarée dans `pubspec.yaml`. |

### Async & cycle de vie (très important)

| Mot-clé | À savoir |
|---------|----------|
| **async** / **await** | Code asynchrone (permissions, dialog, fichiers…). |
| **Future** | Résultat qui arrivera plus tard. |
| **initState()** | Appelé une fois à la création du State. |
| **dispose()** | Appelé à la destruction → libérer controllers / players. |
| **hot reload (`r`)** | Recharge le code sans perdre l’état. |
| **hot restart (`R`)** | Redémarre l’app proprement. |

---

## Concepts TP à retenir

### Listes & UI (TP3)
- `ListView` / `ListView.builder` — liste performante
- `Card` + `ListTile` — présentation propre d’un élément
- `onTap` — action au clic
- `Expanded` — partage l’espace dans une `Row` / `Column`
- `SnackBar` — feedback rapide à l’utilisateur
- `GridView.count` — grille adaptative sur l’accueil

### Formulaires (TP4)
- `Form` + `GlobalKey<FormState>` — validation globale
- `TextEditingController` — lire / contrôler le texte (penser à `dispose`)
- `validator` — message d’erreur si saisie invalide
- Email : non vide + contient `@`
- Mot de passe : min. 8 caractères, `obscureText`, bouton œil
- `SafeArea`, `SingleChildScrollView`, `ConstrainedBox(maxWidth: 420)`
- Material 3 + `ColorScheme.fromSeed` (thème clair / sombre)

### À conserver
Les pages déjà faites restent fonctionnelles : **HomePage**, **CoursesPage**, **ProfilePage**, etc.

Les réponses détaillées sont dans `reponses_tp3.txt` et `reponses_tp4.txt`.

---

## Dépendances principales

| Package | Usage |
|---------|--------|
| `image_picker` | Caméra / galerie |
| `permission_handler` | Permissions (caméra, micro, photos) |
| `record` | Enregistrement audio |
| `audioplayers` | Lecture audio |
| `path_provider` | Dossier temporaire pour les fichiers audio |

---

## Limites actuelles

- Pas de vrai backend : login / inscription = **validation locale** puis navigation ou SnackBar
- Audio multimédia surtout sur **Android / iOS** (limité ou non dispo sur web)
- `ios/`, `linux/`, `macos/` non présents dans ce dépôt

---

## Problèmes fréquents

| Problème | Cause / solution |
|----------|------------------|
| Écran rouge après “Modifier le nom” | Ancien bug : `TextEditingController` disposé trop tôt — **corrigé** dans `profile_page.dart`. Faire `R` (hot restart) |
| App lente | Mode **debug** web → utiliser `--release` |
| `localhost refused to connect` | Serveur Flutter arrêté → relancer `flutter run` |
| Windows : erreur symlink | Activer Developer Mode Windows |
| Port qui change à chaque run | Normal en debug Chrome ; pour un port fixe → `web-server --web-port=8080` |

---

## Contributeurs

- [Badr0h](https://github.com/Badr0h)
- [Salaheddine-Merchich](https://github.com/Salaheddine-Merchich) (collaborateur)
