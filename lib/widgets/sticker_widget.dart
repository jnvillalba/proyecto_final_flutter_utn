// empty_card_widget.dart
import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/models/player.dart';

class StickerWidget extends StatelessWidget {
  final Player player;

  const StickerWidget({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 200,
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
