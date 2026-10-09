import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/screens/home_screen.dart';
import 'package:portfolio/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Fonts are bundled in google_fonts/, never fetched at runtime.
  GoogleFonts.config.allowRuntimeFetching = false;
  // Building the theme starts loading every font; wait for them so the first
  // frame uses the final typography instead of jumping from a fallback.
  AppTheme.dark;
  await GoogleFonts.pendingFonts();
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
