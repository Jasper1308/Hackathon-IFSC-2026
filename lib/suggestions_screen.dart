import 'package:flutter/material.dart';

class SuggestionsScreen extends StatelessWidget {
  const SuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sugestões'),
      ),
      body: const Center(
        child: Text('Tela de sugestões de looks'),
      ),
    );
  }
}