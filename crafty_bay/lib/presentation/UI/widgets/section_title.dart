import 'package:flutter/material.dart';
import '../../utils/theme_colors.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            'See All',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: ThemeColor.accentColor),
          ),
        ),
      ],
    );
  }
}
