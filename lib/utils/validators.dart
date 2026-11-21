String? validateRequired(
  String? value, {
  String message = 'Ce champ est obligatoire',
}) {
  if (value == null || value.trim().isEmpty) {
    return message;
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email obligatoire';
  }

  final email = value.trim();
  if (!email.contains('@')) {
    return 'Email invalide';
  }

  return null;
}

String? validatePassword(String? value, {int minLength = 8}) {
  if (value == null || value.trim().isEmpty) {
    return 'Mot de passe obligatoire';
  }

  if (value.trim().length < minLength) {
    return 'Au moins 8 caractères';
  }

  return null;
}

String? validatePhone(String? value) {
  if (value == null || value.trim().isEmpty) {
    return null;
  }

  final digits = value.replaceAll(RegExp(r'\D'), '');
  if (digits.length < 8) {
    return 'Le téléphone est invalide';
  }

  return null;
}
