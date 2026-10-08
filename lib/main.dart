import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/screens/home_screen.dart';
import 'package:portfolio/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Fonts are bundled in google_fonts/, never fetched at runtime.
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sergio Miguel Trabajo · Flutter Developer',
      theme: AppTheme.dark,
      home: const HomeScreen(),
    );
  }
}
