import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/sticker_mazo.dart';
import 'package:proyecto_final_facil/models/player.dart';

import '../components/sticker_widget.dart';
import '../models/team.dart';

class TeamDetailPage extends StatefulWidget {
  final Team team;

  const TeamDetailPage({super.key, required this.team});

  @override
  TeamDetailPageState createState() => TeamDetailPageState();
}

class TeamDetailPageState extends State<TeamDetailPage> {
  Offset _dragPosition = const Offset(0, 0);
  bool _isDragging = false;
  Player? _draggedPlayer;

  // TODO: Implementar servicio
  List<Player> availableStickers = [];

  void _showStickers(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
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
                child: availableStickers.isEmpty
                    ? Center(
                        child: Text(
                          'No hay stickers disponibles',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: availableStickers.map((player) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                                onDragStarted: () {
                                  setState(() {
                                    _isDragging = true;
                                    _draggedPlayer = player;
                                  });
                                },
                                onDragUpdate: (details) {
                                  setState(() {
                                    _dragPosition = details.globalPosition;
                                  });

                                  if (details.globalPosition.dy <
                                      MediaQuery.of(context).size.height -
                                          200) {
                                    Navigator.pop(context);
                                  }
                                },
                                onDragEnd: (details) {
                                  setState(() {
                                    _dragPosition = details.offset;
                                  });
                                },
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

  void _showMessage(String message, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.team.name),
            Image.network(
              widget.team.badge,
              height: 50,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jugadores:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemCount: widget.team.playerRefs.length,
                    itemBuilder: (context, index) {
                      final teamPlayer = widget.team.playerRefs[index];
                      return FutureBuilder<bool>(
                        future: _isPlayerCollected(teamPlayer as Player),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data == false) {
                            return DragTarget<Player>(
                              onWillAccept: (draggedPlayer) {
                                // Asynchronous check outside of onWillAccept
                                _checkIfPlayerCanBeAccepted(
                                    draggedPlayer, teamPlayer as Player);
                                return true; // Always return true to allow the drag operation
                              },
                              onAccept: (draggedPlayer) {
                                _updatePlayerCollection(
                                    draggedPlayer, teamPlayer as Player);
                              },
                              builder: (context, candidateData, rejectedData) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: candidateData.isNotEmpty
                                          ? Colors.green
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: StickerWidget(
                                      player: teamPlayer as Player),
                                );
                              },
                            );
                          } else {
                            // If the player is collected
                            return StickerCardWidget(
                                player: teamPlayer as Player);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            if (_isDragging && _draggedPlayer != null)
              Positioned(
                left: _dragPosition.dx - 50,
                top: _dragPosition.dy - 80,
                child: Draggable<Player>(
                  data: _draggedPlayer,
                  feedback: SizedBox(
                    height: 160,
                    width: 100,
                    child: StickerCardWidget(player: _draggedPlayer!),
                  ),
                  childWhenDragging: Container(),
                  child: SizedBox(
                    height: 160,
                    width: 100,
                    child: StickerCardWidget(player: _draggedPlayer!),
                  ),
                  onDragEnd: (details) {
                    setState(() {
                      _dragPosition = details.offset;
                    });
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

  Future<void> _checkIfPlayerCanBeAccepted(
      Player? draggedPlayer, Player teamPlayer) async {
    if (draggedPlayer == null) return;

    bool isCollected = await _isPlayerCollected(teamPlayer);
    if (isCollected) {
      _showMessage('Ya pegaste este jugador', false);
    } else if (draggedPlayer.id != teamPlayer.id) {
      _showMessage('Jugador incorrecto', false);
    } else {
      _showMessage('Jugador correcto', true);
    }
  }

  Future<bool> _isPlayerCollected(Player teamPlayer) async {
    final playerSnapshot = await teamPlayer.teamRef.get();
    if (!playerSnapshot.exists) return false;

    final player =
        Player.fromJson(playerSnapshot.data() as Map<String, dynamic>);
    return player.isCollected;
  }

  void _updatePlayerCollection(Player droppedPlayer, Player teamPlayer) {
    setState(() {
      teamPlayer.isCollected = true;
      availableStickers.removeWhere((player) => player.id == droppedPlayer.id);
      _isDragging = false;
      _draggedPlayer = null;
      _showMessage('${teamPlayer.name} agregado a la colección', true);
    });
  }
}
