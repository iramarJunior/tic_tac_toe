import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  const Player({
    Key? key,
    required this.score,
    required this.name,
  }) : super(key: key);
  final int score;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          score.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
