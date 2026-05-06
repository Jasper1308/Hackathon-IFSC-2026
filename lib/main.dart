import 'package:flutter/material.dart';
import 'package:look_link/routes/app_routes.dart';
import 'package:look_link/screens/add_clothing_screen.dart';
import 'package:look_link/screens/friends_screen.dart';
import 'package:look_link/screens/home_screen.dart';
import 'package:look_link/screens/login_screen.dart';
import 'package:look_link/screens/suggestions_screen.dart';
import 'package:look_link/screens/wardrobe_screen.dart';
import 'package:look_link/services/clothing_service.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'providers/clothing_provider.dart';
import 'providers/look_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://bemxempfqwxqbwbmaifr.supabase.co/rest/v1/',
    anonKey: 'sb_publishable_TzWwUu8TojlV8KcaJKhKpQ_BivUiuXc',
  );

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => ClothingService(),
        ),

        ChangeNotifierProvider(
          create: (context) => ClothingProvider(
            context.read<ClothingService>(),
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => LookProvider(),
        ),
      ],
      child: LookLinkApp(),
    ),
  );
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

