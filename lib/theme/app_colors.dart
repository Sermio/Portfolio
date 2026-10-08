import 'package:flutter/painting.dart';

/// Colour tokens of the dark portfolio theme. Components must use these
/// instead of raw hex values.
abstract final class AppColors {
  static const background = Color(0xFF0A0A0F);
  static const surface = Color(0xFF13131B);
  static const surfaceRaised = Color(0xFF1B1B25);
  static const border = Color(0xFF2A2A35);

  static const text = Color(0xFFF4F4F5);
  static const textMuted = Color(0xFFA1A1AA);

  static const amber = Color(0xFFFFB547);
  static const orange = Color(0xFFFF6B2C);
  static const pink = Color(0xFFEA4B71);

  /// Orange tuned for small text on [background] (contrast > 7:1).
  static const accentText = Color(0xFFFF8A4C);

  /// Text and icons placed on top of [brandGradient] or [orange].
  static const onAccent = Color(0xFF0A0A0F);

  static const brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [amber, orange, pink],
  );
}
