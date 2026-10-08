import 'package:flutter/widgets.dart';

abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;
}

abstract final class AppRadius {
  static const double sm = 10;
  static const double md = 16;
  static const double lg = 24;
}

abstract final class AppDurations {
  static const fast = Duration(milliseconds: 180);
  static const medium = Duration(milliseconds: 300);
  static const reveal = Duration(milliseconds: 550);
}

/// Width classes used by every responsive layout in the app.
enum ScreenSize {
  mobile,
  tablet,
  desktop;

  static const double tabletMin = 640;
  static const double desktopMin = 1024;

  /// Maximum width of the page content on large screens.
  static const double maxContentWidth = 1200;

  static ScreenSize fromWidth(double width) {
    if (width >= desktopMin) return ScreenSize.desktop;
    if (width >= tabletMin) return ScreenSize.tablet;
    return ScreenSize.mobile;
  }

  bool get isMobile => this == ScreenSize.mobile;
  bool get isDesktop => this == ScreenSize.desktop;

  /// Horizontal page gutter.
  double get gutter => switch (this) {
        ScreenSize.mobile => AppSpacing.md,
        ScreenSize.tablet => AppSpacing.lg,
        ScreenSize.desktop => AppSpacing.xl,
      };

  /// Vertical padding of each page section.
  double get sectionSpacing => switch (this) {
        ScreenSize.mobile => AppSpacing.xxxl,
        ScreenSize.tablet => 80,
        ScreenSize.desktop => 112,
      };
}

extension ScreenSizeContext on BuildContext {
  ScreenSize get screenSize =>
      ScreenSize.fromWidth(MediaQuery.sizeOf(this).width);

  /// Whether the user asked the platform to reduce motion.
  bool get reduceMotion => MediaQuery.disableAnimationsOf(this);
}
