// Import de la page de détails étudiant
import 'package:emsi_connect/screens/student_details_page.dart';
// Import de Flutter Material
import 'package:flutter/material.dart';

// Page profil avec état
class ProfilePage extends StatefulWidget {
  // Constructeur constant
  const ProfilePage({super.key});

  // Crée l'état de la page
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

// État privé de la page profil
class _ProfilePageState extends State<ProfilePage> {
  // Nom de l'étudiant (modifiable)
  String _studentName = 'Sara El Amrani';
  // Filière (fixe)
  final String _program = 'Informatique';

  // Ouvre une boîte de dialogue pour modifier le nom
  Future<void> _editName() async {
    // Préremplit le champ avec le nom actuel
    final controller = TextEditingController(text: _studentName);
    // Attend le résultat de la boîte de dialogue
    final result = await showDialog<String>(
      context: context,
      // Construit la boîte de dialogue
      builder: (dialogContext) => AlertDialog(
        // Titre
        title: const Text('Modifier le nom'),
        // Champ de saisie
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Nom'),
        ),
        // Boutons d'action
        actions: [
          // Bouton annuler
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Annuler'),
          ),
          // Bouton enregistrer
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, controller.text),
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );

    // Si un nouveau nom valide a été saisi
    if (result != null && result.trim().isNotEmpty) {
      // Met à jour le nom
      setState(() => _studentName = result.trim());
      // Vérifie que le widget est encore monté
      if (!mounted) return;
      // Affiche une confirmation
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Nom modifié')));
    }

    // Libère le contrôleur après la fermeture complète de la boîte de dialogue
    // (évite l'erreur "used after being disposed" pendant l'animation)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.dispose();
    });
  }

  // Construit l'interface
  @override
  Widget build(BuildContext context) {
    // Liste des informations du profil
    final List<_ProfileEntry> entries = [
      // Entrée nom
      _ProfileEntry(
        icon: Icons.person_outline,
        title: 'Nom',
        value: _studentName,
      ),
      // Entrée filière
      const _ProfileEntry(
        icon: Icons.school_outlined,
        title: 'Filière',
        value: 'Informatique',
      ),
      // Entrée niveau
      const _ProfileEntry(
        icon: Icons.workspace_premium_outlined,
        title: 'Niveau',
        value: 'S5',
      ),
      // Entrée email
      const _ProfileEntry(
        icon: Icons.email_outlined,
        title: 'Email',
        value: 'sara@example.com',
      ),
    ];

    // Structure de page
    return Scaffold(
      // Fond clair
      backgroundColor: const Color(0xFFF5FAF7),
      // Barre du haut
      appBar: AppBar(
        title: const Text('Mon profil'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0E8A5E),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      // Contenu défilant
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        // Colonne principale
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bannière + avatar superposés
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Bannière de fond
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  // Icône décorative au centre
                  child: const Center(
                    child: Icon(
                      Icons.account_balance_outlined,
                      size: 48,
                      color: Color(0xFF5A8DEE),
                    ),
                  ),
                ),
                // Avatar positionné en bas de la bannière
                Positioned(
                  bottom: -30,
                  child: CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.person,
                      size: 48,
                      color: Color(0xFF0E8A5E),
                    ),
                  ),
                ),
              ],
            ),
            // Espace pour l'avatar qui dépasse
            const SizedBox(height: 50),
            // Nom centré
            Center(
              child: Text(
                _studentName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF123B2B),
                ),
              ),
            ),
            // Espace
            const SizedBox(height: 20),
            // Titre de section
            const Text(
              'Informations personnelles',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF123B2B),
              ),
            ),
            // Espace
            const SizedBox(height: 10),
            // Badge année universitaire
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '2026–2027',
                style: TextStyle(
                  color: Color(0xFF1A4D89),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Espace
            const SizedBox(height: 18),
            // Affiche chaque entrée du profil
            ...entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                // Carte d'information
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFDBEAFE),
                      width: 1,
                    ),
                  ),
                  // Ligne icône + textes
                  child: Row(
                    children: [
                      // Icône de l'entrée
                      Icon(entry.icon, color: const Color(0xFF0E8A5E)),
                      // Espace
                      const SizedBox(width: 12),
                      // Textes titre et valeur
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Titre (ex: Nom)
                            Text(
                              entry.title,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            // Petit espace
                            const SizedBox(height: 4),
                            // Valeur (ex: Sara...)
                            Text(
                              entry.value,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF123B2B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Espace
            const SizedBox(height: 18),
            // Carte étudiant
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFDDEBFF), width: 1),
              ),
              // Contenu de la carte
              child: Row(
                children: [
                  // Avatar
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFE3F2FD),
                    child: Icon(
                      Icons.person,
                      size: 32,
                      color: Color(0xFF0E8A5E),
                    ),
                  ),
                  // Espace
                  const SizedBox(width: 12),
                  // Infos texte
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Carte étudiant',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Sara El Amrani',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF123B2B),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Informatique • S5',
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'N° étudiant : 20260012',
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  // Icône école
                  const Icon(
                    Icons.school_rounded,
                    size: 30,
                    color: Color(0xFF0E8A5E),
                  ),
                ],
              ),
            ),
            // Espace
            const SizedBox(height: 22),
            // Ligne des deux boutons
            Row(
              children: [
                // Bouton modifier
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _editName(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E8A5E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Modifier le profil'),
                  ),
                ),
                // Espace entre boutons
                const SizedBox(width: 12),
                // Bouton voir détails
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Ouvre la page de détails
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentDetailsPage(
                            studentName: _studentName,
                            program: _program,
                          ),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF0E8A5E),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFF0E8A5E)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Voir les détails'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Modèle d'une entrée du profil
class _ProfileEntry {
  // Constructeur
  const _ProfileEntry({
    required this.icon,
    required this.title,
    required this.value,
  });

  // Icône affichée
  final IconData icon;
  // Titre de l'info
  final String title;
  // Valeur de l'info
  final String value;
}
