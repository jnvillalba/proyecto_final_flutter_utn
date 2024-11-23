import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/stickers_bottom/stickers_modal_header.dart';
import 'package:proyecto_final_facil/models/player.dart';

import 'draggable_sticker.dart';

class BottomContainer extends StatelessWidget {
  final List<Player> availableStickers;
  final ValueChanged<Player> onDragStarted;
  final ValueChanged<Offset> onDragUpdate;
  final VoidCallback onDragEnd;

  const BottomContainer({
    required this.availableStickers,
    required this.onDragStarted,
    required this.onDragUpdate,
    required this.onDragEnd,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StickersModalHeader(availableStickers: availableStickers.length),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: availableStickers.map((player) {
                return DraggableSticker(
                  player: player,
                  onDragStarted: onDragStarted,
                  onDragUpdate: onDragUpdate,
                  onDragEnd: onDragEnd,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
