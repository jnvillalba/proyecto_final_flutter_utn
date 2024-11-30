import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/open_package/package.dart';
import 'package:proyecto_final_facil/components/open_package/shake_widget.dart';
import 'package:proyecto_final_facil/models/player.dart';
import 'package:proyecto_final_facil/services/player_service.dart';

class OpenPackagePage extends StatefulWidget {
  const OpenPackagePage({super.key});

  @override
  OpenPackageState createState() => OpenPackageState();
}

class OpenPackageState extends State<OpenPackagePage> {
  final shakeKey = GlobalKey<ShakeWidgetState>();
  bool showStickers = false;

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

                      if (showStickers) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushNamed(
                            context,
                            '/openedStickers',
                            arguments: {
                              'players': players,
                            },
                          );
                        });
                        showStickers = false;
                        return Container();
                      } else {
                        return ShakeWidget(
                          key: shakeKey,
                          shakeCount: 6,
                          shakeOffset: 10,
                          shakeDuration: const Duration(milliseconds: 600),
                          onShakeComplete: () {
                            setState(() {
                              showStickers = true;
                            });
                          },
                          child: GestureDetector(
                            onTap: () {
                              shakeKey.currentState?.shake();
                            },
                            child: Visibility(
                              visible: !showStickers,
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
}
