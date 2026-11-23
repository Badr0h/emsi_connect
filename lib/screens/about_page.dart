// Import de Flutter Material
import 'package:flutter/material.dart';

// Page "À propos" sans état
class AboutPage extends StatelessWidget {
  // Constructeur constant
  const AboutPage({super.key});

  // Indique que build est redéfini
  @override
  // Construit l'interface de la page
  Widget build(BuildContext context) {
    // Structure de page avec barre d'app et contenu
    return Scaffold(
      // Barre du haut
      appBar: AppBar(
        // Titre de la page
        title: const Text('À propos'),
        // Bouton retour à gauche
        leading: IconButton(
          // Icône flèche retour
          icon: const Icon(Icons.arrow_back),
          // Ferme la page actuelle
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // Contenu centré
      body: const Center(
        // Ajoute un padding autour du texte
        child: Padding(
          // Marge intérieure de 20
          padding: EdgeInsets.all(20),
          // Texte descriptif de l'application
          child: Text(
            'EMSI Connect\nApplication universitaire réalisée dans le cadre des travaux pratiques.',
            // Centre le texte
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
