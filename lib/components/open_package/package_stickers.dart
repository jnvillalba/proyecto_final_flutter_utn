import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/buttons/custom_elevated_btn.dart';
import 'package:proyecto_final_facil/components/sticker.dart';
import 'package:proyecto_final_facil/models/player.dart';

import '../../services/album_service.dart';

class PackageStickers extends StatefulWidget {
  final List<Player> players;

  const PackageStickers({super.key, required this.players});

  @override
  State<PackageStickers> createState() => _PackageStickersState();
}

class _PackageStickersState extends State<PackageStickers> {
  late List<Player> players;
  final List<Player> savedPlayers = [];
  final List<Player> discardedPlayers = [];

  @override
  void initState() {
    super.initState();
    players = List.from(widget.players);
  }

  _cardSwipedRight(Player player) async {
    print("Right");
    print(player.name);
    await addStickerToAlbum(player.id!);

    setState(() {
      players.remove(player);
      _showSnackBar("Sticker guardado: ${player.name}");
    });
  }

  _cardSwipedLeft(Player player) async {
    setState(() {
      players.remove(player);
    });

    if (players.isNotEmpty) {
      _showSnackBar("Sticker descartado: ${players.first.name}");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            players.isEmpty
                ? const Text(
                    "No quedan más stickers",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                : SizedBox(
                    width: 300,
                    height: 500,
                    child: Stack(
                      alignment: Alignment.center,
                      children: players.reversed
                          .toList()
                          .asMap()
                          .entries
                          .map((entry) {
                        final index = entry.key;
                        final player = entry.value;

                        return Positioned(
                          top: index * 10.0,
                          left: index * 10.0,
                          child: Draggable<Player>(
                            data: player,
                            onDragEnd: (details) {
                              if (details.offset.dx > 100) {
                                _cardSwipedRight(players.first);
                              } else if (details.offset.dx < -100) {
                                _cardSwipedLeft(player);
                              }
                            },
                            feedback: _buildCard(player, true),
                            childWhenDragging: Container(),
                            child: _buildCard(player, false),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
            if (players.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedBtn(
                      icon: Icons.close,
                      onTap: () {
                        _cardSwipedLeft(players.first);
                      },
                      backgroundColor: Colors.red,
                      iconColor: Colors.white,
                    ),
                    const SizedBox(width: 40),
                    CustomElevatedBtn(
                      icon: Icons.save_alt,
                      onTap: () {
                        if (players.isNotEmpty) {
                          _cardSwipedRight(players.first);
                        }
                      },
                      backgroundColor: Colors.green,
                      iconColor: Colors.white,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(Player player, bool isDragging) {
    return SizedBox(
      width: 250,
      height: 350,
      child: Sticker(player: player),
    );
  }
}
