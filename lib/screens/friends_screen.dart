import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amigos e Chat'),
      ),
      body: const Center(
        child: Text('Tela de amigos e chat'),
      ),
    );
  }
}