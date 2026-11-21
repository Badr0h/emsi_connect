import 'package:flutter/material.dart';

class CourseItem {
  final String name;
  final String teacher;
  final String hours;
  final IconData icon;

  const CourseItem({
    required this.name,
    required this.teacher,
    required this.hours,
    required this.icon,
  });
}

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  final List<CourseItem> modules = const [
    CourseItem(
      name: 'Programmation mobile',
      teacher: 'M. Benali',
      hours: '24h',
      icon: Icons.smartphone,
    ),
    CourseItem(
      name: 'Base de données',
      teacher: 'Mme. Idrissi',
      hours: '18h',
      icon: Icons.storage,
    ),
    CourseItem(
      name: 'Réseaux',
      teacher: 'M. Bakri',
      hours: '20h',
      icon: Icons.network_check,
    ),
    CourseItem(
      name: 'Algorithmique',
      teacher: 'Mme. Saad',
      hours: '22h',
      icon: Icons.calculate,
    ),
    CourseItem(
      name: 'Gestion de projet',
      teacher: 'M. El Mansouri',
      hours: '16h',
      icon: Icons.assignment,
    ),
    CourseItem(
      name: 'UX/UI Design',
      teacher: 'Mme. Ait Lahsen',
      hours: '14h',
      icon: Icons.design_services,
    ),
    CourseItem(
      name: 'Sécurité informatique',
      teacher: 'M. Saidi',
      hours: '18h',
      icon: Icons.security,
    ),
    CourseItem(
      name: 'Intelligence artificielle',
      teacher: 'M. Yassine',
      hours: '20h',
      icon: Icons.psychology,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FAF7),
      appBar: AppBar(
        title: const Text('Mes cours'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0E8A5E),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: modules.length,
          itemBuilder: (context, index) {
            final module = modules[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: ListTile(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Module sélectionné : ${module.name}'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFE7F7EF),
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Color(0xFF0E8A5E),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(module.name),
                subtitle: Text('${module.teacher} • ${module.hours}'),
                trailing: Icon(module.icon, color: const Color(0xFF0E8A5E)),
              ),
            );
          },
        ),
      ),
    );
  }
}
