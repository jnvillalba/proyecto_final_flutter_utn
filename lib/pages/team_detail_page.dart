import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/sticker_collected.dart';
import 'package:proyecto_final_facil/components/sticker_mazo.dart';
import 'package:proyecto_final_facil/components/stickers_bottom/draggable_sticker_widget.dart';
import 'package:proyecto_final_facil/components/stickers_bottom/stickers_modal_header.dart';
import 'package:proyecto_final_facil/models/player.dart';
import 'package:proyecto_final_facil/models/team.dart';
import 'package:proyecto_final_facil/services/store_services.dart';

class TeamDetailPage extends StatefulWidget {
  const TeamDetailPage({super.key});

  @override
  TeamDetailPageState createState() => TeamDetailPageState();
}

class TeamDetailPageState extends State<TeamDetailPage> {
  late final Team team;

  Offset _dragPosition = const Offset(0, 0);
  bool _isDragging = false;
  Player? _draggedPlayer;

  // TODO: Implementar con persistencia al iniciar
  List<Player> availableStickers = [
    //romero(),
  ];

  List<Player> sortPlayersByPosition(List<Player> players) {
    players.sort((a, b) => a.position.index.compareTo(b.position.index));
    return players;
  }

  void _showStickers(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const StickersModalHeader(),
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
                            return DraggableStickerWidget(
                              player: player,
                              onDragStarted: (draggedPlayer) {
                                setState(() {
                                  _isDragging = true;
                                  _draggedPlayer = draggedPlayer;
                                });
                              },
                              onDragUpdate: (position) {
                                setState(() {
                                  _dragPosition = position;
                                });
                                if (position.dy <
                                    MediaQuery.of(context).size.height - 200) {
                                  Navigator.pop(context);
                                }
                              },
                              onDragEnd: () {
                                setState(() {
                                  _dragPosition = Offset.zero;
                                });
                              },
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
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return FutureBuilder(
      future: getTeamWithPlayers(arguments['teamId']),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Scaffold(
            //TODO: pantalla de rror
            appBar: AppBar(title: const Text('Error')),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        if (snapshot.hasData) {
          team = snapshot.data!;

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
            body: _buildPlayers(context),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showStickers(context),
              child: const Icon(Icons.list),
            ),
          );
        }

        // Caso donde no hay datos
        return Scaffold(
          appBar: AppBar(title: const Text('Sin datos')),
          body: const Center(child: Text('No se encontraron datos.')),
        );
      },
    );
  }

//TODO implementar servicio
  void _updatePlayerCollection(Player droppedPlayer, Player teamPlayer) {
    setState(() {
      teamPlayer.isCollected = true;
      availableStickers.removeWhere((player) => player.id == droppedPlayer.id);
      _isDragging = false;
      _draggedPlayer = null;
      _showMessage('${teamPlayer.name} agregado a la colección', true);
    });
  }

  Widget _buildPlayers(BuildContext context) {
    return Padding(
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemCount: team.players?.length,
                  itemBuilder: (context, index) {
                    final teamPlayer =
                        sortPlayersByPosition(team.players!)[index];
                    return DragTarget<Player>(
                      onWillAccept: (draggedPlayer) {
                        if (teamPlayer.isCollected) {
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
                        _updatePlayerCollection(draggedPlayer, teamPlayer);
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
                          child: teamPlayer.isCollected
                              ? StickerCardWidget(player: teamPlayer)
                              : StickerCollected(player: teamPlayer),
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
    );
  }
}
