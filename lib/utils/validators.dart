// Vérifie qu'un champ obligatoire n'est pas vide
String? validateRequired(
  // Valeur saisie par l'utilisateur
  String? value, {
  // Message d'erreur personnalisable
  String message = 'Ce champ est obligatoire',
}) {
  // Si la valeur est nulle ou vide après nettoyage
  if (value == null || value.trim().isEmpty) {
    // Retourne le message d'erreur
    return message;
  }
  // Sinon la validation est OK
  return null;
}

// Vérifie qu'un email est correctement rempli
String? validateEmail(String? value) {
  // Si l'email est vide
  if (value == null || value.trim().isEmpty) {
    // Retourne une erreur
    return 'Email obligatoire';
  }

  // Nettoie les espaces autour de l'email
  final email = value.trim();
  // Vérifie la présence du symbole @
  if (!email.contains('@')) {
    // Email invalide sans @
    return 'Email invalide';
  }

  // Email valide
  return null;
}

// Vérifie qu'un mot de passe est assez long
String? validatePassword(String? value, {int minLength = 8}) {
  // Si le mot de passe est vide
  if (value == null || value.trim().isEmpty) {
    // Retourne une erreur
    return 'Mot de passe obligatoire';
  }

  // Si le mot de passe est trop court
  if (value.trim().length < minLength) {
    // Demande au moins 8 caractères
    return 'Au moins 8 caractères';
  }

  // Mot de passe valide
  return null;
}

// Vérifie un numéro de téléphone (optionnel)
String? validatePhone(String? value) {
  // Si le champ est vide, c'est accepté (optionnel)
  if (value == null || value.trim().isEmpty) {
    // Pas d'erreur
    return null;
  }

  // Garde uniquement les chiffres
  final digits = value.replaceAll(RegExp(r'\D'), '');
  // Vérifie qu'il y a au moins 8 chiffres
  if (digits.length < 8) {
    // Numéro trop court
    return 'Le téléphone est invalide';
  }

  // Téléphone valide
  return null;
}
