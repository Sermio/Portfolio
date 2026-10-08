import 'package:flutter/foundation.dart';

@immutable
class Experience {
  const Experience({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
  });

  final String role;
  final String company;
  final String period;
  final String description;
}
