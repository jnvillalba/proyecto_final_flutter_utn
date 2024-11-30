import 'package:flutter/material.dart';

class SquareBtn extends StatelessWidget {
  final String imagePath;
  final double height;
  final Function()? onTap;

  const SquareBtn({
    super.key,
    required this.imagePath,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Image.asset(
          imagePath,
          height: height,
        ),
      ),
    );
  }
}
