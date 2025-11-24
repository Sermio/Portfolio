import 'package:flutter/material.dart';

import 'package:portfolio/data/data.dart';

class WebHeader extends StatelessWidget {
  const WebHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 150),
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
            child: ClipOval(
              child: Image.network(
                'https://raw.githubusercontent.com/Sermio/Portfolio/refs/heads/main/assets/images/img.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 200,
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(Icons.person, size: 80),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
