import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/empty_sticker.dart';
import 'package:proyecto_final_facil/components/open_package/package.dart';
import 'package:proyecto_final_facil/components/open_package/shake_widget.dart';
import 'package:proyecto_final_facil/models/player.dart';
import 'package:proyecto_final_facil/services/player_service.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class OpenPackagePage extends StatefulWidget {
  const OpenPackagePage({super.key});

  @override
  OpenPackageState createState() => OpenPackageState();
}

class OpenPackageState extends State<OpenPackagePage> {
  final shakeKey = GlobalKey<ShakeWidgetState>();
  bool showStikcers = false;
  final List<String> titles = ['', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                FutureBuilder<List<Player>>(
                  future: openPack(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No hay jugadores disponibles');
                    } else {
                      final players = snapshot.data!;
                      final images = players
                          .map((player) => EmptySticker(player: player))
                          .toList();

                      return showStikcers
                          ? Expanded(
                              child: VerticalCardPager(
                                titles: titles,
                                images: images,
                                onSelectedItem: (index) {
                                  _deletePlayer(players[index]);
                                },
                                initialPage: 2,
                                align: ALIGN.CENTER,
                                physics: const ClampingScrollPhysics(),
                              ),
                            )
                          : ShakeWidget(
                              key: shakeKey,
                              shakeCount: 6,
                              shakeOffset: 10,
                              shakeDuration: const Duration(milliseconds: 600),
                              onShakeComplete: () {
                                setState(() {
                                  showStikcers = true;
                                });
                              },
                              child: GestureDetector(
                                onTap: () {
                                  shakeKey.currentState?.shake();
                                },
                                child: Visibility(
                                  visible: !showStikcers,
                                  child: const Column(
                                    children: [
                                      Package(),
                                      SizedBox(height: 20),
                                      Text(
                                        'Toca para abrir',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white70,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deletePlayer(Player player) async {
    try {
      //descartar jugador
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al guardar jugador: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
