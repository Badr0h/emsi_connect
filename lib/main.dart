// Import du package Flutter pour l'interface Material
import 'package:flutter/material.dart';
// Import de la page d'accueil de l'application
import 'package:emsi_connect/screens/home_page.dart';

// Point d'entrée de l'application
void main() {
  // Lance l'application avec le widget MyApp
  runApp(const MyApp());
}

// Widget racine de l'application (sans état)
class MyApp extends StatelessWidget {
  // Constructeur constant de MyApp
  const MyApp({super.key});

  // Indique que la méthode ci-dessous redéfinit build
  @override
  // Construit l'interface de l'application
  Widget build(BuildContext context) {
    // Crée le thème de couleurs clair à partir d'une couleur de base
    final lightScheme = ColorScheme.fromSeed(
      // Couleur principale EMSI (vert)
      seedColor: const Color(0xFF0E8A5E),
      // Mode clair
      brightness: Brightness.light,
    );
    // Crée le thème de couleurs sombre à partir de la même couleur
    final darkScheme = ColorScheme.fromSeed(
      // Couleur principale EMSI (vert)
      seedColor: const Color(0xFF0E8A5E),
      // Mode sombre
      brightness: Brightness.dark,
    );

    // Style des champs de saisie pour le thème clair
    final lightInputTheme = InputDecorationTheme(
      // Active le fond rempli du champ
      filled: true,
      // Couleur de fond du champ
      fillColor: const Color(0xFFF8F9FA),
      // Espacement intérieur du texte
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      // Bordure par défaut du champ
      border: OutlineInputBorder(
        // Coins arrondis
        borderRadius: BorderRadius.circular(14),
        // Couleur de bordure semi-transparente
        borderSide: BorderSide(
          color: lightScheme.primary.withValues(alpha: 0.4),
        ),
      ),
      // Bordure quand le champ est actif mais non focus
      enabledBorder: OutlineInputBorder(
        // Coins arrondis
        borderRadius: BorderRadius.circular(14),
        // Couleur de bordure un peu plus claire
        borderSide: BorderSide(
          color: lightScheme.primary.withValues(alpha: 0.35),
        ),
      ),
      // Bordure quand le champ est sélectionné
      focusedBorder: OutlineInputBorder(
        // Coins arrondis
        borderRadius: BorderRadius.circular(14),
        // Bordure plus épaisse et colorée
        borderSide: BorderSide(color: lightScheme.primary, width: 2),
      ),
      // Bordure en cas d'erreur
      errorBorder: OutlineInputBorder(
        // Coins arrondis
        borderRadius: BorderRadius.circular(14),
        // Couleur d'erreur du thème
        borderSide: BorderSide(color: lightScheme.error),
      ),
      // Bordure d'erreur quand le champ est focus
      focusedErrorBorder: OutlineInputBorder(
        // Coins arrondis
        borderRadius: BorderRadius.circular(14),
        // Bordure d'erreur plus épaisse
        borderSide: BorderSide(color: lightScheme.error, width: 2),
      ),
      // Style du label du champ
      labelStyle: TextStyle(color: lightScheme.onSurfaceVariant),
      // Style du texte d'aide (hint)
      hintStyle: TextStyle(
        color: lightScheme.onSurfaceVariant.withValues(alpha: 0.7),
      ),
    );

    // Style des champs de saisie pour le thème sombre
    final darkInputTheme = InputDecorationTheme(
      // Active le fond rempli du champ
      filled: true,
      // Couleur de fond sombre du champ
      fillColor: const Color(0xFF1E1E1E),
      // Espacement intérieur du texte
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      // Bordure par défaut
      border: OutlineInputBorder(
        // Coins arrondis
        borderRadius: BorderRadius.circular(14),
        // Couleur de bordure semi-transparente
        borderSide: BorderSide(
          color: darkScheme.primary.withValues(alpha: 0.5),
        ),
      ),
      // Bordure quand le champ est actif
      enabledBorder: OutlineInputBorder(
        // Coins arrondis
        borderRadius: BorderRadius.circular(14),
        // Couleur de bordure
        borderSide: BorderSide(
          color: darkScheme.primary.withValues(alpha: 0.4),
        ),
      ),
      // Bordure quand le champ est focus
      focusedBorder: OutlineInputBorder(
        // Coins arrondis
        borderRadius: BorderRadius.circular(14),
        // Bordure primaire plus épaisse
        borderSide: BorderSide(color: darkScheme.primary, width: 2),
      ),
      // Bordure en cas d'erreur
      errorBorder: OutlineInputBorder(
        // Coins arrondis
        borderRadius: BorderRadius.circular(14),
        // Couleur d'erreur
        borderSide: BorderSide(color: darkScheme.error),
      ),
      // Bordure d'erreur focus
      focusedErrorBorder: OutlineInputBorder(
        // Coins arrondis
        borderRadius: BorderRadius.circular(14),
        // Bordure d'erreur plus épaisse
        borderSide: BorderSide(color: darkScheme.error, width: 2),
      ),
      // Style du label
      labelStyle: TextStyle(color: darkScheme.onSurfaceVariant),
      // Style du hint
      hintStyle: TextStyle(
        color: darkScheme.onSurfaceVariant.withValues(alpha: 0.7),
      ),
    );

    // Retourne l'application Material
    return MaterialApp(
      // Titre de l'application
      title: 'EMSI Connect',
      // Cache la bannière "DEBUG"
      debugShowCheckedModeBanner: false,
      // Thème clair
      theme: ThemeData(
        // Active Material Design 3
        useMaterial3: true,
        // Applique le schéma de couleurs clair
        colorScheme: lightScheme,
        // Couleur de fond des pages
        scaffoldBackgroundColor: const Color(0xFFF5FAF7),
        // Applique le style des champs clairs
        inputDecorationTheme: lightInputTheme,
      ),
      // Thème sombre
      darkTheme: ThemeData(
        // Active Material Design 3
        useMaterial3: true,
        // Applique le schéma de couleurs sombre
        colorScheme: darkScheme,
        // Couleur de fond des pages en mode sombre
        scaffoldBackgroundColor: const Color(0xFF121212),
        // Applique le style des champs sombres
        inputDecorationTheme: darkInputTheme,
      ),
      // Page affichée au démarrage
      home: const HomePage(),
    );
  }
}
