import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/models/player.dart';

class EmptySticker extends StatelessWidget {
  final Player player;

  const EmptySticker({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: Image.network(
              player.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                player.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}