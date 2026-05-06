import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),

          const Center(
            child: CircleAvatar(
              radius: 48,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.person,
                color: Colors.black,
                size: 48,
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Center(
            child: Text(
              'Adrian Jasper',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 6),

          Center(
            child: Text(
              '@adrian',
              style: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),
          ),

          const SizedBox(height: 36),

          _optionTile(
            icon: Icons.favorite_outline,
            title: 'Looks salvos',
          ),

          _optionTile(
            icon: Icons.swap_horiz,
            title: 'Peças em desapego',
          ),

          _optionTile(
            icon: Icons.settings_outlined,
            title: 'Configurações',
          ),

          _optionTile(
            icon: Icons.help_outline,
            title: 'Ajuda',
          ),
        ],
      ),
    );
  }

  Widget _optionTile({
    required IconData icon,
    required String title,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(22),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.green,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 16,
        ),
      ),
    );
  }
}