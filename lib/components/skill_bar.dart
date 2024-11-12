import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SkillBar extends StatelessWidget {
  const SkillBar({super.key, required this.skillName, required this.percent});

  final String skillName;
  final double percent;

  Color _getColor(double percent) {
    if (percent < 0.1) {
      return Colors.red[900]!;
    } else if (percent < 0.2) {
      return Colors.red[700]!;
    } else if (percent < 0.3) {
      return Colors.orange;
    } else if (percent < 0.4) {
      return Colors.yellow[700]!;
    } else if (percent < 0.5) {
      return Colors.yellow[500]!;
    } else if (percent < 0.6) {
      return Colors.lightGreen;
    } else if (percent < 0.7) {
      return Colors.green[400]!;
    } else if (percent < 0.8) {
      return Colors.green[600]!;
    } else if (percent < 0.9) {
      return Colors.blue[400]!;
    } else {
      return Colors.blue[600]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 30, 0),
            child: Text(
              skillName,
            ),
          ),
          // const SizedBox(height: 4),
          LinearPercentIndicator(
            width: 100.0,
            lineHeight: 8.0,
            percent: percent,
            progressColor: _getColor(percent),
            barRadius: const Radius.circular(20),
          ),
        ],
      ),
    );
  }
}
