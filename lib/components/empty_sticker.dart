import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/delete_alert_dialog.dart';
import 'package:proyecto_final_facil/models/enums/player_position.dart';
import 'package:proyecto_final_facil/models/player.dart';

class EmptySticker extends StatelessWidget {
  final Player player;
  final VoidCallback? onDelete;

  const EmptySticker({super.key, required this.player, this.onDelete});

  Color _getBackgroundColor(PlayerPosition position) {
    switch (position) {
      case PlayerPosition.forward:
        return Colors.red;
      case PlayerPosition.goalkeeper:
        return Colors.yellow;
      case PlayerPosition.midfielder:
        return Colors.lightGreen;
      case PlayerPosition.defender:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getPosition(PlayerPosition position) {
    switch (position) {
      case PlayerPosition.forward:
        return 'DEL';
      case PlayerPosition.goalkeeper:
        return 'POR';
      case PlayerPosition.midfielder:
        return 'MED';
      case PlayerPosition.defender:
        return 'DEF';
      default:
        return 'N/A';
    }
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    if (onDelete == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => const DeleteAlertDialog(className: 'jugador'),
    );

    if (confirmed == true) {
      onDelete!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onDelete != null
          ? () => _showDeleteConfirmationDialog(context)
          : null,
      child: SizedBox(
        width: 200,
        height: 300,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getBackgroundColor(player.position),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${player.number}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _getPosition(player.position),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    child: Image.network(
                      player.imageUrl,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: 150,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(2.0),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      player.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
