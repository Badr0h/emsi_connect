// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:emsi_connect/main.dart';
import 'package:emsi_connect/screens/home_page.dart';
import 'package:emsi_connect/screens/login_page.dart';

void main() {
  testWidgets('MyApp starts on HomePage', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(const MyApp());

    expect(find.text('EMSI Connect'), findsOneWidget);
    expect(find.text('Bienvenue sur EMSI Connect'), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('LoginPage loads and can validate empty email and password', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    expect(find.text('Connexion'), findsOneWidget);
    expect(find.text('Email obligatoire'), findsNothing);

    await tester.tap(find.text('Vérifier la saisie'));
    await tester.pump();

    expect(find.text('Email obligatoire'), findsOneWidget);
    expect(find.text('Mot de passe obligatoire'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'test@emsi.com');
    await tester.enterText(find.byType(TextFormField).at(1), '1234');
    await tester.tap(find.text('Vérifier la saisie'));
    await tester.pump();

    expect(find.text('Au moins 8 caractères'), findsOneWidget);
  });

  testWidgets(
    'LoginPage validates email without @ and toggles password visibility',
    (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      addTearDown(() async {
        await tester.binding.setSurfaceSize(null);
      });

      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      await tester.enterText(find.byType(TextFormField).at(0), 'test');
      await tester.enterText(find.byType(TextFormField).at(1), 'Password123');
      await tester.tap(find.text('Vérifier la saisie'));
      await tester.pump();

      expect(find.text('Email invalide'), findsOneWidget);

      final eyeButton = find.byIcon(Icons.visibility_outlined);
      expect(eyeButton, findsOneWidget);
      await tester.tap(eyeButton);
      await tester.pump();

      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    },
  );
}
