import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LookLink'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.login,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _menuButton(
              context,
              title: 'Meu Armário',
              icon: Icons.checkroom,
              route: AppRoutes.wardrobe,
            ),
            const SizedBox(height: 16),
            _menuButton(
              context,
              title: 'Cadastrar Roupa',
              icon: Icons.add_a_photo,
              route: AppRoutes.addClothing,
            ),
            const SizedBox(height: 16),
            _menuButton(
              context,
              title: 'Amigos e Chat',
              icon: Icons.people,
              route: AppRoutes.friends,
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(
      BuildContext context, {
        required String title,
        required IconData icon,
        required String route,
      }) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}