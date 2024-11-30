import 'package:flutter/material.dart';

class DeleteAlertDialog extends StatelessWidget {
  final String className;

  const DeleteAlertDialog({super.key, required this.className});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('¿Estás seguro de que quieres borrar el $className?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Borrar'),
        ),
      ],
    );
  }
}
