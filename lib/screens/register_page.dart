// Import des validateurs
import 'package:emsi_connect/utils/validators.dart';
// Import de Flutter Material
import 'package:flutter/material.dart';

// Page d'inscription avec état
class RegisterPage extends StatefulWidget {
  // Constructeur constant
  const RegisterPage({super.key});

  // Crée l'état de la page
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

// État privé de la page d'inscription
class _RegisterPageState extends State<RegisterPage> {
  // Clé du formulaire
  final _formKey = GlobalKey<FormState>();
  // Contrôleur du nom complet
  final _fullNameController = TextEditingController();
  // Contrôleur de l'email
  final _emailController = TextEditingController();
  // Contrôleur du mot de passe
  final _passwordController = TextEditingController();
  // Contrôleur de la confirmation
  final _confirmPasswordController = TextEditingController();
  // Contrôleur du téléphone
  final _phoneController = TextEditingController();
  // Contrôleur de la description
  final _descriptionController = TextEditingController();

  // Masque le mot de passe
  bool _obscurePassword = true;
  // Masque la confirmation
  bool _obscureConfirmPassword = true;

  // Libère tous les contrôleurs
  @override
  void dispose() {
    // Libère le nom
    _fullNameController.dispose();
    // Libère l'email
    _emailController.dispose();
    // Libère le mot de passe
    _passwordController.dispose();
    // Libère la confirmation
    _confirmPasswordController.dispose();
    // Libère le téléphone
    _phoneController.dispose();
    // Libère la description
    _descriptionController.dispose();
    // Appelle dispose du parent
    super.dispose();
  }

  // Vérifie puis confirme la validité du formulaire
  void _submitForm() {
    // Arrête si le formulaire est invalide
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Affiche un message de succès de validation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Formulaire valide — compte non créé'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Construit l'interface
  @override
  Widget build(BuildContext context) {
    // Couleurs du thème
    final colorScheme = Theme.of(context).colorScheme;

    // Structure de page
    return Scaffold(
      // Barre du haut
      appBar: AppBar(title: const Text('Inscription'), centerTitle: true),
      // Contenu hors zones système
      body: SafeArea(
        // Défilement si besoin
        child: SingleChildScrollView(
          // Marge intérieure
          padding: const EdgeInsets.all(20),
          // Centre le formulaire
          child: Center(
            // Largeur max pour lisibilité
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              // Formulaire
              child: Form(
                // Lie la clé
                key: _formKey,
                // Colonne des champs
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Icône d'ajout d'utilisateur
                    Icon(
                      Icons.person_add_alt_1_rounded,
                      size: 80,
                      color: colorScheme.primary,
                    ),
                    // Espace sous l'icône
                    const SizedBox(height: 24),
                    // Champ nom complet
                    TextFormField(
                      controller: _fullNameController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Nom complet',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      // Champ obligatoire
                      validator: (value) => validateRequired(
                        value,
                        message: 'Le nom est obligatoire',
                      ),
                    ),
                    // Espace
                    const SizedBox(height: 16),
                    // Champ email
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'prenom@emsi.ma',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: validateEmail,
                    ),
                    // Espace
                    const SizedBox(height: 16),
                    // Champ mot de passe
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        prefixIcon: const Icon(Icons.lock_outline),
                        // Bouton afficher/masquer
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: validatePassword,
                    ),
                    // Espace
                    const SizedBox(height: 16),
                    // Champ confirmation mot de passe
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Confirmation du mot de passe',
                        prefixIcon: const Icon(Icons.lock_reset_outlined),
                        // Bouton afficher/masquer
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      // Vérifie la confirmation
                      validator: (value) {
                        // Champ vide
                        if (value == null || value.trim().isEmpty) {
                          return 'La confirmation du mot de passe est obligatoire';
                        }
                        // Doit être identique au mot de passe
                        if (value != _passwordController.text) {
                          return 'Les mots de passe ne correspondent pas';
                        }
                        // OK
                        return null;
                      },
                    ),
                    // Espace
                    const SizedBox(height: 16),
                    // Champ téléphone
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Téléphone',
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                      validator: validatePhone,
                    ),
                    // Espace
                    const SizedBox(height: 16),
                    // Champ description
                    TextFormField(
                      controller: _descriptionController,
                      // Limite à 150 caractères
                      maxLength: 150,
                      // Plusieurs lignes
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        prefixIcon: Icon(Icons.description_outlined),
                      ),
                      // Affiche le compteur de caractères
                      buildCounter:
                          (
                            context, {
                            required currentLength,
                            required isFocused,
                            required maxLength,
                          }) {
                            return Text('$currentLength / $maxLength');
                          },
                    ),
                    // Espace avant le bouton
                    const SizedBox(height: 24),
                    // Bouton de création de compte
                    FilledButton.icon(
                      onPressed: _submitForm,
                      icon: const Icon(Icons.person_add_alt_1),
                      label: const Text('Créer mon compte'),
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
