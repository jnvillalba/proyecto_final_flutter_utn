import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/sticker.dart';
import 'package:proyecto_final_facil/models/player.dart';

class DraggableSticker extends StatelessWidget {
  final Player player;
  final ValueChanged<Player> onDragStarted;
  final ValueChanged<Offset> onDragUpdate;
  final VoidCallback onDragEnd;

  const DraggableSticker({
    super.key,
    required this.player,
    required this.onDragStarted,
    required this.onDragUpdate,
    required this.onDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Draggable<Player>(
        data: player,
        feedback: SizedBox(
          height: 160,
          width: 100,
          child: Sticker(player: player),
        ),
        childWhenDragging: Opacity(
          opacity: 0.5,
          child: SizedBox(
            height: 160,
            width: 100,
            child: Sticker(player: player),
          ),
        ),
        child: SizedBox(
            height: 200,
            width: 125,
            child: Sticker(
              player: player,
            )),
        onDragStarted: () => onDragStarted(player),
        onDragUpdate: (details) => onDragUpdate(details.globalPosition),
        onDragEnd: (_) => onDragEnd(),
      ),
    );
  }
}
