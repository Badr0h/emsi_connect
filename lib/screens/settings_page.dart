// Import de Flutter Material
import 'package:flutter/material.dart';

// Page des paramètres avec état
class SettingsPage extends StatefulWidget {
  // Constructeur constant
  const SettingsPage({super.key});

  // Crée l'état associé à cette page
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

// État privé de la page Paramètres
class _SettingsPageState extends State<SettingsPage> {
  // Indique si les notifications sont activées
  bool notifications = true;
  // Indique si le mode compact est activé
  bool compactMode = false;
  // Indique si les infos complémentaires sont affichées
  bool additionalInfo = true;

  // Affiche un message de confirmation
  void _confirm(String message) {
    // Montre un SnackBar en bas de l'écran
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  // Construit l'interface
  @override
  Widget build(BuildContext context) {
    // Structure de page
    return Scaffold(
      // Barre du haut
      appBar: AppBar(
        // Titre
        title: const Text('Paramètres'),
        // Bouton retour
        leading: IconButton(
          // Icône flèche
          icon: const Icon(Icons.arrow_back),
          // Revient à la page précédente
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // Liste défilante des options
      body: ListView(
        // Marge autour de la liste
        padding: const EdgeInsets.all(16),
        children: [
          // Interrupteur des notifications
          SwitchListTile(
            // Titre de l'option
            title: const Text('Notifications'),
            // Affiche l'état actuel
            subtitle: Text('Activées : $notifications'),
            // Valeur de l'interrupteur
            value: notifications,
            // Quand l'utilisateur change la valeur
            onChanged: (value) {
              // Met à jour l'état
              setState(() => notifications = value);
              // Affiche une confirmation
              _confirm('Notifications : ${value ? 'activées' : 'désactivées'}');
            },
          ),
          // Interrupteur du mode compact
          SwitchListTile(
            // Titre
            title: const Text('Mode compact'),
            // Affiche l'état
            subtitle: Text('Activé : $compactMode'),
            // Valeur actuelle
            value: compactMode,
            // Mise à jour au changement
            onChanged: (value) {
              // Met à jour l'état
              setState(() => compactMode = value);
              // Confirmation visuelle
              _confirm('Mode compact : ${value ? 'activé' : 'désactivé'}');
            },
          ),
          // Interrupteur des infos complémentaires
          SwitchListTile(
            // Titre
            title: const Text('Informations complémentaires'),
            // Affiche l'état
            subtitle: Text('Affichées : $additionalInfo'),
            // Valeur actuelle
            value: additionalInfo,
            // Mise à jour au changement
            onChanged: (value) {
              // Met à jour l'état
              setState(() => additionalInfo = value);
              // Confirmation visuelle
              _confirm(
                'Informations complémentaires : ${value ? 'affichées' : 'masquées'}',
              );
            },
          ),
          // Affiche la carte seulement si l'option est activée
          if (additionalInfo)
            // Carte d'information
            const Card(
              // Contenu avec padding
              child: Padding(
                // Marge intérieure
                padding: EdgeInsets.all(16),
                // Texte affiché
                child: Text('Informations complémentaires disponibles'),
              ),
            ),
        ],
      ),
    );
  }
}
