import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'services/firebase_service.dart';
import 'providers/menu_provider.dart';
import 'screens/main_navigation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SmartIdlyKadaiApp());
}

class SmartIdlyKadaiApp extends StatelessWidget {
  const SmartIdlyKadaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create the Firebase service instance
    final firebaseService = FirebaseService();

    return MultiProvider(
      providers: [
        Provider<FirebaseService>.value(value: firebaseService),
        ChangeNotifierProvider<MenuProvider>(
          create: (context) => MenuProvider(firebaseService),
        ),
      ],
      child: MaterialApp(
        title: 'Smart Idly Kadai',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFD35400), // South Indian Terracotta/Orange
            primary: const Color(0xFFD35400),
            secondary: const Color(0xFFF39C12), // Warm Amber
            background: const Color(0xFFFFFDF9), // Warm Cream background
            surface: Colors.white,
            error: const Color(0xFFC0392B),
          ),
          scaffoldBackgroundColor: const Color(0xFFFFFDF9),
          cardTheme: const CardThemeData(
            color: Colors.white,
            elevation: 2,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
          textTheme: GoogleFonts.outfitTextTheme(
            ThemeData.light().textTheme,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: const Color(0xFFFFFDF9),
            elevation: 0,
            iconTheme: const IconThemeData(color: Color(0xFF2C3E50)),
            titleTextStyle: GoogleFonts.outfit(
              color: const Color(0xFF2C3E50),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Color(0xFFD35400),
            unselectedItemColor: Color(0xFF7F8C8D),
            backgroundColor: Colors.white,
            elevation: 8,
          ),
        ),
        home: const MainNavigationScreen(),
      ),
    );
  }
}
