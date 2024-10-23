import 'package:flutter/material.dart';

class IconBackButton extends StatelessWidget {
  const IconBackButton({
    super.key,
    required this.whereToBack,
  });

  final VoidCallback whereToBack;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios,
        size: 22,
      ),
      onPressed: whereToBack,
    );
  }
}
