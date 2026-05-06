import 'package:flutter/material.dart';

import 'routes/app_routes.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/wardrobe_screen.dart';
import 'screens/add_clothing_screen.dart';
import 'screens/friends_screen.dart';
import 'screens/suggestions_screen.dart';

void main() {
  runApp(const LookLinkApp());
}

class LookLinkApp extends StatelessWidget {
  const LookLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LookLink',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.wardrobe: (context) => WardrobeScreen(),
        AppRoutes.addClothing: (context) => AddClothingScreen(),
        AppRoutes.friends: (context) => FriendsScreen(),
        AppRoutes.suggestions: (context) => SuggestionsScreen(),
      },
    );
  }
}