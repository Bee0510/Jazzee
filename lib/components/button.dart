import 'package:flutter/material.dart';
import 'package:jazzee/core/theme/base_font';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onPressed,
    required this.color,
    required this.text,
    required this.minimumSize,
  });

  final VoidCallback onPressed;
  final Color color;
  final String text;
  final Size minimumSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: minimumSize,
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.mediumRegular
            .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
