import 'package:flutter/material.dart';

class StickersModalHeader extends StatelessWidget {
  const StickersModalHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Figuritas disponibles:',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
