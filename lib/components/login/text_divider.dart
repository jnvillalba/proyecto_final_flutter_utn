import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  final String text;
  final Color dividerColor;
  final Color textColor;
  final double thickness;

  const TextDivider({
    super.key,
    this.text = 'OR',
    this.dividerColor = Colors.white,
    this.textColor = Colors.white,
    this.thickness = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: thickness,
              color: dividerColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: thickness,
              color: dividerColor,
            ),
          ),
        ],
      ),
    );
  }
}
