// Import de la page d'accueil
import 'package:emsi_connect/screens/home_page.dart';
// Import des fonctions de validation
import 'package:emsi_connect/utils/validators.dart';
// Import de Flutter Material
import 'package:flutter/material.dart';

// Page de connexion avec état
class LoginPage extends StatefulWidget {
  // Constructeur constant
  const LoginPage({super.key});

  // Crée l'état de la page
  @override
  State<LoginPage> createState() => _LoginPageState();
}

// État privé de la page de connexion
class _LoginPageState extends State<LoginPage> {
  // Clé pour valider le formulaire
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Contrôleur du champ email
  final TextEditingController _emailController = TextEditingController();
  // Contrôleur du champ mot de passe
  final TextEditingController _passwordController = TextEditingController();

  // Cache ou affiche le mot de passe
  bool _obscurePassword = true;

  // Libère les ressources à la fermeture
  @override
  void dispose() {
    // Libère le contrôleur email
    _emailController.dispose();
    // Libère le contrôleur mot de passe
    _passwordController.dispose();
    // Appelle dispose du parent
    super.dispose();
  }

  // Vérifie le formulaire puis navigue
  void _submitForm() {
    // Si le formulaire est invalide, on s'arrête
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Remplace la page de login par l'accueil
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  // Construit l'interface
  @override
  Widget build(BuildContext context) {
    // Récupère les couleurs du thème actuel
    final colorScheme = Theme.of(context).colorScheme;

    // Structure de page
    return Scaffold(
      // Barre du haut
      appBar: AppBar(title: const Text('Connexion'), centerTitle: true),
      // Contenu protégé des zones système
      body: SafeArea(
        // Permet de défiler si le clavier apparaît
        child: SingleChildScrollView(
          // Marge intérieure
          padding: const EdgeInsets.all(20),
          // Centre le formulaire
          child: Center(
            // Limite la largeur sur grand écran
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              // Formulaire avec validation
              child: Form(
                // Lie la clé au formulaire
                key: _formKey,
                // Colonne verticale des champs
                child: Column(
                  // Étire les enfants en largeur
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Petit espace en haut
                    const SizedBox(height: 16),
                    // Icône de cadenas
                    Icon(
                      Icons.lock_outline_rounded,
                      size: 84,
                      color: colorScheme.primary,
                    ),
                    // Espace sous l'icône
                    const SizedBox(height: 24),
                    // Champ email
                    TextFormField(
                      // Lie le contrôleur email
                      controller: _emailController,
                      // Clavier adapté aux emails
                      keyboardType: TextInputType.emailAddress,
                      // Passe au champ suivant
                      textInputAction: TextInputAction.next,
                      // Décoration du champ
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'prenom@emsi.ma',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      // Validation de l'email
                      validator: validateEmail,
                    ),
                    // Espace entre les champs
                    const SizedBox(height: 18),
                    // Champ mot de passe
                    TextFormField(
                      // Lie le contrôleur mot de passe
                      controller: _passwordController,
                      // Masque le texte si besoin
                      obscureText: _obscurePassword,
                      // Valide avec Entrée
                      textInputAction: TextInputAction.done,
                      // Décoration du champ
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        hintText: '********',
                        prefixIcon: const Icon(Icons.lock_outline),
                        // Bouton œil pour afficher/masquer
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Change l'icône selon l'état
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          // Inverse l'affichage du mot de passe
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      // Validation du mot de passe
                      validator: validatePassword,
                    ),
                    // Espace avant le bouton
                    const SizedBox(height: 26),
                    // Bouton de validation
                    FilledButton.icon(
                      // Lance la soumission
                      onPressed: _submitForm,
                      // Icône de validation
                      icon: const Icon(Icons.check_circle_outline),
                      // Texte du bouton
                      label: const Text('Vérifier la saisie'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
