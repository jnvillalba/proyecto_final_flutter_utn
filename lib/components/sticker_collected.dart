import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/models/player.dart';

class StickerCollected extends StatelessWidget {
  final Player player;

  const StickerCollected({super.key, required this.player, isCollected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
      ),
      alignment: Alignment.center,
      child: Text(
        player.name,
        style: const TextStyle(fontSize: 18, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
