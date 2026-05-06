import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _onBottomMenuTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushNamed(context, AppRoutes.wardrobe);
        break;
      case 2:
        Navigator.pushNamed(context, AppRoutes.friends);
        break;
      case 3:
        Navigator.pushNamed(context, AppRoutes.settings);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text(
          'LookLink',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Feed',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          _feedCard(
            icon: Icons.checkroom,
            title: 'Marina adicionou uma nova peça',
            subtitle: 'Jaqueta jeans disponível para combinação.',
            actionText: 'Ver peça',
          ),

          _feedCard(
            icon: Icons.chat_bubble_outline,
            title: 'João comentou no seu look',
            subtitle: '“Essa camiseta combina muito com aquela calça preta.”',
            actionText: 'Abrir conversa',
          ),

          _feedCard(
            icon: Icons.shopping_bag_outlined,
            title: 'Peça à venda perto de você',
            subtitle: 'Tênis branco casual por R\$ 89,90.',
            actionText: 'Ver anúncio',
          ),

          _feedCard(
            icon: Icons.auto_awesome,
            title: 'Sugestão da IA',
            subtitle:
            'Sua calça jeans combina com camiseta branca e tênis casual.',
            actionText: 'Montar look',
          ),

          _feedCard(
            icon: Icons.people_outline,
            title: 'Novo armário conectado',
            subtitle: 'Ana agora compartilha peças com você.',
            actionText: 'Ver armário',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) => _onBottomMenuTap(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checkroom),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _feedCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionText,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.green.shade100,
              child: Icon(
                icon,
                color: Colors.green.shade700,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    actionText,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}