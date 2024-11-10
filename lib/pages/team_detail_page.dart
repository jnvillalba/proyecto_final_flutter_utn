import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/data.dart';
import 'package:proyecto_final_facil/models/player.dart';
import 'package:proyecto_final_facil/widgets/sticker_mazo.dart';

import '../models/team.dart';
import '../widgets/sticker_widget.dart';

class TeamDetailPage extends StatelessWidget {
  final Team team;

  const TeamDetailPage({super.key, required this.team});

  void _showStickers(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        List<Player> availableStickers = [
          romero(),
          romero(),
          romero(),
          romero(),
        ];

        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Figuritas disponibles:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 160,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: availableStickers.map((player) {
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
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(team.name),
            Image.network(
              team.badge,
              height: 50,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jugadores:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemCount: team.players.length,
                itemBuilder: (context, index) {
                  return DragTarget<Player>(
                    onAccept: (player) {
                      // TODO Handle the accepted player here
                    },
                    builder: (context, candidateData, rejectedData) {
                      return StickerWidget(player: team.players[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showStickers(context),
        child: const Icon(Icons.list),
      ),
    );
  }
}
