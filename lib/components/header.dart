import 'package:flutter/material.dart';

import 'package:portfolio/data/data.dart';

class WebHeader extends StatelessWidget {
  const WebHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 150),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  kGradient1,
                  kGradient2,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            child: CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage(
                imagePath,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
