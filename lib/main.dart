import 'package:flutter/material.dart';
import 'package:look_link/providers/auth_provider.dart';
import 'package:look_link/providers/user_provider.dart';
import 'package:look_link/routes/app_routes.dart';
import 'package:look_link/screens/add_clothing_screen.dart';
import 'package:look_link/screens/complete_profile_screen.dart';
import 'package:look_link/screens/friends_screen.dart';
import 'package:look_link/screens/home_screen.dart';
import 'package:look_link/screens/login_screen.dart';
import 'package:look_link/screens/suggestions_screen.dart';
import 'package:look_link/screens/wardrobe_screen.dart';
import 'package:look_link/services/clothing_service.dart';
import 'package:look_link/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'providers/clothing_provider.dart';
import 'providers/look_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://bemxempfqwxqbwbmaifr.supabase.co',
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

        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => UserProvider(
            UserService(),
          ),
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
    const bg = Color(0xFF0F0F0F);
    const surface = Color(0xFF1A1A1A);
    return MaterialApp(
      title: 'LookLink',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
          surface: surface,
        ),
        useMaterial3: true,
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF262626),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
        ),
        cardTheme: const CardTheme(
          color: surface,
          elevation: 0,
          margin: EdgeInsets.zero,
        ),
      ),
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.wardrobe: (context) => WardrobeScreen(),
        AppRoutes.addClothing: (context) => AddClothingScreen(),
        AppRoutes.friends: (context) => FriendsScreen(),
        AppRoutes.suggestions: (context) => SuggestionsScreen(),
        AppRoutes.completeProfile: (context) => const CompleteProfileScreen(),
      },
    );
  }
}

