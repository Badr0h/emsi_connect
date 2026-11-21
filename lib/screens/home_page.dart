import 'package:emsi_connect/screens/about_page.dart';
import 'package:emsi_connect/screens/courses_page.dart';
import 'package:emsi_connect/screens/login_page.dart';
import 'package:emsi_connect/screens/profile_page.dart';
import 'package:emsi_connect/screens/settings_page.dart';
import 'package:emsi_connect/screens/multimedia_page.dart'; // Import de la page multimédia
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.onToggleTheme});

  final VoidCallback? onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final List<_CategoryItem> categories = [
      const _CategoryItem(title: 'Mes cours', icon: Icons.menu_book),
      const _CategoryItem(title: 'Planning', icon: Icons.calendar_month),
      const _CategoryItem(title: 'Mon profil', icon: Icons.person),
      const _CategoryItem(title: 'Mes tâches', icon: Icons.task_alt),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAF7),
      appBar: AppBar(
        title: const Text('EMSI Connect'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0E8A5E),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => debugPrint('Notifications consultées'),
            icon: const Icon(Icons.notifications_none_rounded),
            tooltip: 'Notifications',
          ),
          if (onToggleTheme != null)
            IconButton(
              onPressed: onToggleTheme,
              icon: const Icon(Icons.dark_mode_outlined),
              tooltip: 'Changer le thème',
            ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF0E8A5E)),
              accountName: Text('Sara El Amrani'),
              accountEmail: Text('sara@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Color(0xFF0E8A5E)),
              ),
            ),
            _DrawerItem(
              icon: Icons.home,
              title: 'Accueil',
              onTap: () => Navigator.pop(context),
            ),
            _DrawerItem(
              icon: Icons.menu_book,
              title: 'Mes cours',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CoursesPage()),
                );
              },
            ),
            _DrawerItem(
              icon: Icons.person,
              title: 'Mon profil',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              },
            ),
            _DrawerItem(
              icon: Icons.image, // Changement de l'icône ici
              title: 'Espace multimédia',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MultimediaPage()),
                );
              },
            ),
            _DrawerItem(
              icon: Icons.info_outline,
              title: 'À propos',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutPage()),
                );
              },
            ),
            _DrawerItem(
              icon: Icons.settings,
              title: 'Paramètres',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
            ),
            const Divider(),
            _DrawerItem(
              icon: Icons.logout,
              title: 'Déconnexion',
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth < 600 ? 2 : 3;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                    const SizedBox(height: 24),
                    const Text(
                      'Bienvenue sur EMSI Connect',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF123B2B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Votre espace universitaire pour accéder à vos cours, votre planning et vos informations personnelles.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => debugPrint('Fonctionnalité bientôt disponible'),
        backgroundColor: const Color(0xFF0E8A5E),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.item});

  final _CategoryItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigation vers la page correspondante
        switch (item.title) {
          case 'Mes cours':
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const CoursesPage()));
            break;
          case 'Planning':
            // Action pour Planning
            debugPrint('Planning sélectionné');
            break;
          case 'Mon profil':
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const ProfilePage()));
            break;
          case 'Mes tâches':
            // Action pour Mes tâches
            debugPrint('Mes tâches sélectionné');
            break;
          default:
            debugPrint('Catégorie inconnue');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF4FF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFCFE4FF), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFFDDEEFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item.icon, size: 28, color: const Color(0xFF0E8A5E)),
            ),
            const SizedBox(height: 12),
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

class _CategoryItem {
  const _CategoryItem({required this.title, required this.icon});

  final String title;
  final IconData icon;
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Row(
          children: [
            Icon(icon, size: 28, color: const Color(0xFF0E8A5E)),
            const SizedBox(width: 16),
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
