import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/empty_sticker.dart';
import 'package:proyecto_final_facil/components/open_package/package.dart';
import 'package:proyecto_final_facil/components/open_package/shake_widget.dart';
import 'package:proyecto_final_facil/data.dart';
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

  final List<Widget> images = [
    EmptySticker(player: playersBoca()[0]),
    EmptySticker(player: playersBoca()[1]),
    EmptySticker(player: playersBoca()[2]),
    EmptySticker(player: playersBoca()[3]),
    EmptySticker(player: playersBoca()[4])
  ];

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
                showStikcers
                    ? Expanded(
                        child: VerticalCardPager(
                          titles: titles,
                          images: images,
                          onSelectedItem: (index) {},
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
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
