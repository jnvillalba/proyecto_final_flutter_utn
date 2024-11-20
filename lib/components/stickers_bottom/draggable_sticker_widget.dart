import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/sticker_mazo.dart';
import 'package:proyecto_final_facil/models/player.dart';

class DraggableStickerWidget extends StatelessWidget {
  final Player player;
  final ValueChanged<Player> onDragStarted;
  final ValueChanged<Offset> onDragUpdate;
  final VoidCallback onDragEnd;

  const DraggableStickerWidget({
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
          child: StickerCardWidget(player: player),
        ),
        childWhenDragging: Opacity(
          opacity: 0.5,
          child: SizedBox(
            height: 160,
            width: 100,
            child: StickerCardWidget(player: player),
          ),
        ),
        child: SizedBox(
          height: 160,
          width: 100,
          child: StickerCardWidget(player: player),
        ),
        onDragStarted: () => onDragStarted(player),
        onDragUpdate: (details) => onDragUpdate(details.globalPosition),
        onDragEnd: (_) => onDragEnd(),
      ),
    );
  }
}
