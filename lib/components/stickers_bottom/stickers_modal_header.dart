import 'package:flutter/material.dart';

class StickersModalHeader extends StatelessWidget {
  final int availableStickers;

  const StickersModalHeader({super.key, required this.availableStickers});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          availableStickers > 0
              ? 'Figuritas disponibles:'
              : 'No hay Figuritas disponibles',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
