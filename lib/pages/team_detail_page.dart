import 'package:flutter/material.dart';
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
          Player.gk(
            id: '1',
            name: 'Sergio Romero',
            imageUrl:
                'https://img.a.transfermarkt.technology/portrait/header/30690-1596803710.jpg?lm=1',
          ),
        ];

        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Figuritas disponibles:',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // Evita el scroll
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemCount: availableStickers.length,
                itemBuilder: (context, index) {
                  return Draggable<Player>(
                      data: availableStickers[index],
                      feedback: SizedBox(
                          height: 100,
                          width: 100,
                          child: StickerCardWidget(
                              player: availableStickers[index])),
                      childWhenDragging: Opacity(
                          opacity: 0.5,
                          child: StickerCardWidget(
                              player: availableStickers[index])),
                      child:
                          StickerCardWidget(player: availableStickers[index]));
                },
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
