import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/open_package/package_stickers.dart';

class OpenedStickersPage extends StatelessWidget {
  const OpenedStickersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/menu');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sobre abierto'),
          automaticallyImplyLeading: false,
        ),
        body: PackageStickers(players: arguments['players']),
      ),
    );
  }
}
