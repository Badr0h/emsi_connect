// Import de la page À propos
import 'package:emsi_connect/screens/about_page.dart';
// Import de la page des cours
import 'package:emsi_connect/screens/courses_page.dart';
// Import de la page de connexion
import 'package:emsi_connect/screens/login_page.dart';
// Import de la page profil
import 'package:emsi_connect/screens/profile_page.dart';
// Import de la page paramètres
import 'package:emsi_connect/screens/settings_page.dart';
// Import de la page multimédia
import 'package:emsi_connect/screens/multimedia_page.dart';
// Import de Flutter Material
import 'package:flutter/material.dart';

// Page d'accueil sans état
class HomePage extends StatelessWidget {
  // Constructeur avec callback optionnel pour le thème
  const HomePage({super.key, this.onToggleTheme});

  // Fonction optionnelle pour changer le thème
  final VoidCallback? onToggleTheme;

  // Construit l'interface
  @override
  Widget build(BuildContext context) {
    // Liste des catégories affichées en grille
    final List<_CategoryItem> categories = [
      const _CategoryItem(title: 'Mes cours', icon: Icons.menu_book),
      const _CategoryItem(title: 'Planning', icon: Icons.calendar_month),
      const _CategoryItem(title: 'Mon profil', icon: Icons.person),
      const _CategoryItem(title: 'Mes tâches', icon: Icons.task_alt),
    ];

    // Structure de page
    return Scaffold(
      // Fond clair
      backgroundColor: const Color(0xFFF5FAF7),
      // Barre du haut
      appBar: AppBar(
        title: const Text('EMSI Connect'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0E8A5E),
        foregroundColor: Colors.white,
        elevation: 0,
        // Actions à droite
        actions: [
          // Bouton notifications
          IconButton(
            onPressed: () => debugPrint('Notifications consultées'),
            icon: const Icon(Icons.notifications_none_rounded),
            tooltip: 'Notifications',
          ),
          // Bouton thème seulement si le callback existe
          if (onToggleTheme != null)
            IconButton(
              onPressed: onToggleTheme,
              icon: const Icon(Icons.dark_mode_outlined),
              tooltip: 'Changer le thème',
            ),
        ],
      ),
      // Menu latéral
      drawer: Drawer(
        // Liste des éléments du menu
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // En-tête avec infos utilisateur
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF0E8A5E)),
              accountName: Text('Sara El Amrani'),
              accountEmail: Text('sara@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Color(0xFF0E8A5E)),
              ),
            ),
            // Lien Accueil
            _DrawerItem(
              icon: Icons.home,
              title: 'Accueil',
              onTap: () => Navigator.pop(context),
            ),
            // Lien Mes cours
            _DrawerItem(
              icon: Icons.menu_book,
              title: 'Mes cours',
              onTap: () {
                // Ferme le tiroir
                Navigator.pop(context);
                // Ouvre la page cours
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CoursesPage()),
                );
              },
            ),
            // Lien Mon profil
            _DrawerItem(
              icon: Icons.person,
              title: 'Mon profil',
              onTap: () {
                // Ferme le tiroir
                Navigator.pop(context);
                // Ouvre la page profil
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              },
            ),
            // Lien Espace multimédia
            _DrawerItem(
              icon: Icons.image,
              title: 'Espace multimédia',
              onTap: () {
                // Ferme le tiroir
                Navigator.pop(context);
                // Ouvre la page multimédia
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MultimediaPage()),
                );
              },
            ),
            // Lien À propos
            _DrawerItem(
              icon: Icons.info_outline,
              title: 'À propos',
              onTap: () {
                // Ferme le tiroir
                Navigator.pop(context);
                // Ouvre la page À propos
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutPage()),
                );
              },
            ),
            // Lien Paramètres
            _DrawerItem(
              icon: Icons.settings,
              title: 'Paramètres',
              onTap: () {
                // Ferme le tiroir
                Navigator.pop(context);
                // Ouvre la page paramètres
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
            ),
            // Séparateur
            const Divider(),
            // Lien Déconnexion
            _DrawerItem(
              icon: Icons.logout,
              title: 'Déconnexion',
              onTap: () {
                // Remplace toute la pile de navigation par Login
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      // Contenu principal
      body: SafeArea(
        // Adapte la grille selon la largeur
        child: LayoutBuilder(
          builder: (context, constraints) {
            // 2 colonnes sur mobile, 3 sur tablette
            final crossAxisCount = constraints.maxWidth < 600 ? 2 : 3;

            // Contenu défilant
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              // Garantit une hauteur minimale
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                // Colonne principale
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo EMSI centré
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/emsi.png',
                          height: 160,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    // Espace
                    const SizedBox(height: 24),
                    // Titre de bienvenue
                    const Text(
                      'Bienvenue sur EMSI Connect',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF123B2B),
                      ),
                    ),
                    // Espace
                    const SizedBox(height: 12),
                    // Texte descriptif
                    const Text(
                      'Votre espace universitaire pour accéder à vos cours, votre planning et vos informations personnelles.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    // Espace
                    const SizedBox(height: 20),
                    // Grille des catégories
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                      // Transforme chaque catégorie en carte
                      children: categories
                          .map((category) => _CategoryCard(item: category))
                          .toList(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      // Bouton flottant
      floatingActionButton: FloatingActionButton(
        onPressed: () => debugPrint('Fonctionnalité bientôt disponible'),
        backgroundColor: const Color(0xFF0E8A5E),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Carte cliquable d'une catégorie
class _CategoryCard extends StatelessWidget {
  // Constructeur avec l'élément obligatoire
  const _CategoryCard({required this.item});

  // Données de la catégorie
  final _CategoryItem item;

  // Construit la carte
  @override
  Widget build(BuildContext context) {
    // Détecte le clic
    return GestureDetector(
      onTap: () {
        // Navigue selon le titre
        switch (item.title) {
          case 'Mes cours':
            // Ouvre la page cours
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const CoursesPage()));
            break;
          case 'Planning':
            // Pas encore implémenté
            debugPrint('Planning sélectionné');
            break;
          case 'Mon profil':
            // Ouvre la page profil
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const ProfilePage()));
            break;
          case 'Mes tâches':
            // Pas encore implémenté
            debugPrint('Mes tâches sélectionné');
            break;
          default:
            // Cas inconnu
            debugPrint('Catégorie inconnue');
        }
      },
      // Conteneur visuel de la carte
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF4FF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFCFE4FF), width: 1),
        ),
        // Contenu vertical
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Carré avec l'icône
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFFDDEEFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item.icon, size: 28, color: const Color(0xFF0E8A5E)),
            ),
            // Espace
            const SizedBox(height: 12),
            // Titre de la catégorie
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF123B2B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Modèle d'une catégorie
class _CategoryItem {
  // Constructeur
  const _CategoryItem({required this.title, required this.icon});

  // Titre affiché
  final String title;
  // Icône affichée
  final IconData icon;
}

// Élément cliquable du menu latéral
class _DrawerItem extends StatelessWidget {
  // Constructeur
  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  // Icône du menu
  final IconData icon;
  // Titre du menu
  final String title;
  // Action au clic
  final VoidCallback onTap;

  // Construit l'élément
  @override
  Widget build(BuildContext context) {
    // Zone cliquable avec effet d'encre
    return InkWell(
      onTap: onTap,
      // Contenu avec padding
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        // Ligne icône + texte
        child: Row(
          children: [
            // Icône
            Icon(icon, size: 28, color: const Color(0xFF0E8A5E)),
            // Espace
            const SizedBox(width: 16),
            // Titre
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF123B2B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
