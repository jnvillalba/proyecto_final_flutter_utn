import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/sticker_mazo.dart';
import 'package:proyecto_final_facil/components/sticker_widget.dart';
import 'package:proyecto_final_facil/models/player.dart';
import 'package:proyecto_final_facil/models/team.dart';

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

  // TODO: Implementar con persistencia al iniciar
  List<Player> availableStickers = [
    //romero(),
  ];

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
                    itemCount: widget.team.players?.length,
                    itemBuilder: (context, index) {
                      final teamPlayer = widget.team.players?[index];
                      return DragTarget<Player>(
                        onWillAccept: (draggedPlayer) {
                          if (teamPlayer!.isCollected) {
                            //TODO: mejora que aparezca al soltar
                            _showMessage('Ya pegaste este juador', false);
                            return false;
                          }
                          if (draggedPlayer?.id != teamPlayer.id) {
                            _showMessage('Jugador incorrecto', false);
                            return false;
                          }

                          return true;
                        },
                        onAccept: (draggedPlayer) {
                          _updatePlayerCollection(draggedPlayer, teamPlayer!);
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
                            child: teamPlayer!.isCollected
                                ? StickerCardWidget(player: teamPlayer)
                                : StickerWidget(player: teamPlayer),
                          );
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
