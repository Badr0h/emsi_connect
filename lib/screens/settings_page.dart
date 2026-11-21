import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notifications = true;
  bool compactMode = false;
  bool additionalInfo = true;

  void _confirm(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Notifications'),
            subtitle: Text('Activées : $notifications'),
            value: notifications,
            onChanged: (value) {
              setState(() => notifications = value);
              _confirm('Notifications : ${value ? 'activées' : 'désactivées'}');
            },
          ),
          SwitchListTile(
            title: const Text('Mode compact'),
            subtitle: Text('Activé : $compactMode'),
            value: compactMode,
            onChanged: (value) {
              setState(() => compactMode = value);
              _confirm('Mode compact : ${value ? 'activé' : 'désactivé'}');
            },
          ),
          SwitchListTile(
            title: const Text('Informations complémentaires'),
            subtitle: Text('Affichées : $additionalInfo'),
            value: additionalInfo,
            onChanged: (value) {
              setState(() => additionalInfo = value);
              _confirm(
                'Informations complémentaires : ${value ? 'affichées' : 'masquées'}',
              );
            },
          ),
          if (additionalInfo)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('Informations complémentaires disponibles'),
              ),
            ),
        ],
      ),
    );
  }
}
