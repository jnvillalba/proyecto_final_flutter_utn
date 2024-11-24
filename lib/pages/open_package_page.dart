import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/open_package/package.dart';
import 'package:proyecto_final_facil/components/open_package/shake_widget.dart';

class OpenPackagePage extends StatefulWidget {
  const OpenPackagePage({super.key});

  @override
  OpenPackageState createState() => OpenPackageState();
}

class OpenPackageState extends State<OpenPackagePage> {
  final shakeKey = GlobalKey<ShakeWidgetState>();
  bool showStikcers = false;

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
                // Only show the ShakeWidget (Package) if stickers are not shown
                ShakeWidget(
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
                      shakeKey.currentState
                          ?.shake(); // Trigger shake when tapped
                    },
                    child: Visibility(
                      visible: !showStikcers,
                      // Hide the original package when stickers are shown
                      child: const Package(),
                    ),
                  ),
                ),
                if (showStikcers) ...[
                  const Text(
                    "List of Envelopes",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ...List.generate(5, (index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Package(), // Display the closed envelope
                    );
                  }),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
