import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/empty_sticker.dart';
import 'package:proyecto_final_facil/models/player.dart';
import 'package:proyecto_final_facil/services/album_service.dart';

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
          child: EmptySticker(player: player),
        ),
        childWhenDragging: Opacity(
          opacity: 0.5,
          child: SizedBox(
            height: 160,
            width: 100,
            child: EmptySticker(player: player),
          ),
        ),
        child: SizedBox(
            height: 150,
            width: 125,
            child: EmptySticker(
              player: player,
              onDelete: () {},
            )),
        onDragStarted: () => onDragStarted(player),
        onDragUpdate: (details) => onDragUpdate(details.globalPosition),
        onDragEnd: (_) => onDragEnd(),
      ),
    );
  }

  void _onDelete() {
    removeStickerFromAlbum(player.id!);
  }
}
