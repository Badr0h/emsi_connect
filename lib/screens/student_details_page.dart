// Import de Flutter Material
import 'package:flutter/material.dart';

// Page qui affiche les détails d'un étudiant
class StudentDetailsPage extends StatelessWidget {
  // Constructeur avec nom et filière obligatoires
  const StudentDetailsPage({
    super.key,
    // Nom de l'étudiant reçu de la page précédente
    required this.studentName,
    // Filière reçue de la page précédente
    required this.program,
  });

  // Stocke le nom de l'étudiant
  final String studentName;
  // Stocke la filière
  final String program;

  // Indique que build est redéfini
  @override
  // Construit l'interface
  Widget build(BuildContext context) {
    // Structure de page
    return Scaffold(
      // Barre du haut avec le titre
      appBar: AppBar(title: const Text('Détails de l’étudiant')),
      // Contenu centré
      body: Center(
        // Ajoute un padding
        child: Padding(
          // Marge intérieure de 20
          padding: const EdgeInsets.all(20),
          // Colonne verticale
          child: Column(
            // Prend seulement la hauteur nécessaire
            mainAxisSize: MainAxisSize.min,
            // Étire les enfants en largeur
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Affiche le nom de l'étudiant
              Text('Étudiant : $studentName', textAlign: TextAlign.center),
              // Petit espace vertical
              const SizedBox(height: 8),
              // Affiche la filière
              Text('Filière : $program', textAlign: TextAlign.center),
              // Espace avant le bouton
              const SizedBox(height: 24),
              // Bouton pour revenir en arrière
              FilledButton.icon(
                // Ferme la page
                onPressed: () => Navigator.pop(context),
                // Icône retour
                icon: const Icon(Icons.arrow_back),
                // Texte du bouton
                label: const Text('Retour'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
