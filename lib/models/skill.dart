import 'package:flutter/foundation.dart';

@immutable
class Skill {
  const Skill({required this.name, required this.percent});

  final String name;

  /// Self-assessed level between 0 and 1.
  final double percent;
}
