import 'package:flutter/material.dart';
import '../../utils/theme_colors.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker(
      {super.key,
      required this.availableColors,
      required this.onSelectedColor});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
  final List<Color> availableColors;
  final Function(Color) onSelectedColor;
}

class _ColorPickerState extends State<ColorPicker> {
  late Color _selectedColor = widget.availableColors.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w400,
                color: ThemeColor.darkGrey,
              ),
        ),
        Wrap(
          spacing: 6,
          children: widget.availableColors.map((color) {
            return InkWell(
              onTap: () {
                _selectedColor = color;
                widget.onSelectedColor(color);
                setState(() {});
              },
              child: CircleAvatar(
                backgroundColor: color,
                radius: 12,
                child: _selectedColor == color
                    ? const Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 18,
                      )
                    : null,
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
