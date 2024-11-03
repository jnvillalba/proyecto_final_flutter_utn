import 'package:flutter/material.dart';

import '../models/team.dart';
import '../widgets/sticker_widget.dart';

class TeamDetailPage extends StatelessWidget {
  final Team team;

  const TeamDetailPage({super.key, required this.team});

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
              child: Center(
                // Añadido Center aquí
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: team.players.map((player) {
                    return StickerWidget(
                      player: player,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
