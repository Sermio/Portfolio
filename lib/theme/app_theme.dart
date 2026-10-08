import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/theme/app_colors.dart';
import 'package:portfolio/theme/app_layout.dart';

/// Dark theme: Poppins for display text, Inter for everything else.
/// Both are bundled in `google_fonts/` (weights 400–700).
abstract final class AppTheme {
  static ThemeData get dark {
    final base = ThemeData(useMaterial3: true, brightness: Brightness.dark);
    final textTheme = GoogleFonts.interTextTheme(base.textTheme)
        .copyWith(
          displayLarge: GoogleFonts.poppins(
              fontSize: 64,
              fontWeight: FontWeight.w700,
              height: 1.05,
              letterSpacing: -1.5),
          displayMedium: GoogleFonts.poppins(
              fontSize: 44,
              fontWeight: FontWeight.w700,
              height: 1.1,
              letterSpacing: -1),
          displaySmall: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              height: 1.15,
              letterSpacing: -0.5),
          headlineSmall: GoogleFonts.poppins(
              fontSize: 26, fontWeight: FontWeight.w600, height: 1.25),
          titleLarge: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.w600, height: 1.3),
          titleMedium: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, height: 1.4),
          bodyLarge: GoogleFonts.inter(fontSize: 17, height: 1.65),
          bodyMedium: GoogleFonts.inter(fontSize: 15, height: 1.6),
          bodySmall: GoogleFonts.inter(fontSize: 13, height: 1.5),
          labelLarge:
              GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
          labelMedium: GoogleFonts.inter(
              fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.2),
          labelSmall: GoogleFonts.inter(
              fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 2),
        )
        .apply(bodyColor: AppColors.text, displayColor: AppColors.text);

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(color: AppColors.border),
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.orange,
        onPrimary: AppColors.onAccent,
        secondary: AppColors.pink,
        onSecondary: AppColors.onAccent,
        tertiary: AppColors.amber,
        surface: AppColors.surface,
        onSurface: AppColors.text,
        onSurfaceVariant: AppColors.textMuted,
        surfaceContainerHighest: AppColors.surfaceRaised,
        outline: AppColors.border,
      ),
      textTheme: textTheme,
      dividerColor: AppColors.border,
      dividerTheme:
          const DividerThemeData(color: AppColors.border, thickness: 1),
      hoverColor: Colors.white.withValues(alpha: 0.04),
      focusColor: AppColors.orange.withValues(alpha: 0.24),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.orange,
        selectionColor: AppColors.orange.withValues(alpha: 0.35),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
        prefixIconColor: AppColors.textMuted,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.md),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.orange, width: 1.5),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.surfaceRaised,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: AppColors.border),
        ),
        textStyle: textTheme.bodySmall,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStatePropertyAll(Colors.white.withValues(alpha: 0.2)),
      ),
      iconTheme: const IconThemeData(color: AppColors.text),
    );
  }
}
