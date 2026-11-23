// Import de Flutter Material
import 'package:flutter/material.dart';

// Modèle de données pour un cours
class CourseItem {
  // Nom du module
  final String name;
  // Nom de l'enseignant
  final String teacher;
  // Nombre d'heures
  final String hours;
  // Icône associée
  final IconData icon;

  // Constructeur constant avec tous les champs obligatoires
  const CourseItem({
    required this.name,
    required this.teacher,
    required this.hours,
    required this.icon,
  });
}

// Page qui liste les cours
class CoursesPage extends StatelessWidget {
  // Constructeur constant
  const CoursesPage({super.key});

  // Liste des modules à afficher
  final List<CourseItem> modules = const [
    // Module programmation mobile
    CourseItem(
      name: 'Programmation mobile',
      teacher: 'M. Benali',
      hours: '24h',
      icon: Icons.smartphone,
    ),
    // Module base de données
    CourseItem(
      name: 'Base de données',
      teacher: 'Mme. Idrissi',
      hours: '18h',
      icon: Icons.storage,
    ),
    // Module réseaux
    CourseItem(
      name: 'Réseaux',
      teacher: 'M. Bakri',
      hours: '20h',
      icon: Icons.network_check,
    ),
    // Module algorithmique
    CourseItem(
      name: 'Algorithmique',
      teacher: 'Mme. Saad',
      hours: '22h',
      icon: Icons.calculate,
    ),
    // Module gestion de projet
    CourseItem(
      name: 'Gestion de projet',
      teacher: 'M. El Mansouri',
      hours: '16h',
      icon: Icons.assignment,
    ),
    // Module UX/UI
    CourseItem(
      name: 'UX/UI Design',
      teacher: 'Mme. Ait Lahsen',
      hours: '14h',
      icon: Icons.design_services,
    ),
    // Module sécurité
    CourseItem(
      name: 'Sécurité informatique',
      teacher: 'M. Saidi',
      hours: '18h',
      icon: Icons.security,
    ),
    // Module IA
    CourseItem(
      name: 'Intelligence artificielle',
      teacher: 'M. Yassine',
      hours: '20h',
      icon: Icons.psychology,
    ),
  ];

  // Construit l'interface
  @override
  Widget build(BuildContext context) {
    // Structure de page
    return Scaffold(
      // Fond vert très clair
      backgroundColor: const Color(0xFFF5FAF7),
      // Barre du haut
      appBar: AppBar(
        // Titre
        title: const Text('Mes cours'),
        // Centre le titre
        centerTitle: true,
        // Couleur de fond verte
        backgroundColor: const Color(0xFF0E8A5E),
        // Couleur du texte et des icônes
        foregroundColor: Colors.white,
      ),
      // Contenu avec padding
      body: Padding(
        // Marge autour de la liste
        padding: const EdgeInsets.all(16),
        // Liste construite dynamiquement
        child: ListView.builder(
          // Nombre d'éléments = taille de la liste
          itemCount: modules.length,
          // Construit chaque ligne
          itemBuilder: (context, index) {
            // Récupère le module à l'index courant
            final module = modules[index];

            // Carte visuelle pour le module
            return Card(
              // Espace sous chaque carte
              margin: const EdgeInsets.only(bottom: 12),
              // Ombre légère
              elevation: 2,
              // Forme arrondie
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              // Ligne avec titre, sous-titre et icône
              child: ListTile(
                // Action au clic
                onTap: () {
                  // Affiche un SnackBar avec le nom du module
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Module sélectionné : ${module.name}'),
                      // SnackBar flottant
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                // Avatar avec le numéro du module
                leading: CircleAvatar(
                  // Fond vert clair
                  backgroundColor: const Color(0xFFE7F7EF),
                  // Affiche l'index + 1
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Color(0xFF0E8A5E),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Nom du module
                title: Text(module.name),
                // Enseignant et heures
                subtitle: Text('${module.teacher} • ${module.hours}'),
                // Icône à droite
                trailing: Icon(module.icon, color: const Color(0xFF0E8A5E)),
              ),
            );
          },
        ),
      ),
    );
  }
}
