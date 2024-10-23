import 'package:crafty_bay/presentation/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class TextColorPicker extends StatefulWidget {
  const TextColorPicker(
      {super.key, required this.onSelectedColor, required this.availableColor});

  @override
  State<TextColorPicker> createState() => _TextColorPickerState();
  final List<String> availableColor;
  final Function(String) onSelectedColor;
}

class _TextColorPickerState extends State<TextColorPicker> {
  late String _selectedSize = widget.availableColor.first;

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
          children: widget.availableColor.map((size) {
            return InkWell(
              onTap: () {
                _selectedSize = size;
                widget.onSelectedColor(size);
                setState(() {});
              },
              child: Container(
                height: 25,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: _selectedSize == size
                          ? ThemeColor.accentColor
                          : ThemeColor.darkGrey,
                      width: 1),
                  borderRadius: BorderRadius.circular(3),
                  color: _selectedSize == size
                      ? ThemeColor.accentColor
                      : Colors.white,
                ),
                child: Center(
                  child: Text(
                    size,
                    style: TextStyle(
                        color: _selectedSize == size
                            ? Colors.white
                            : ThemeColor.darkGrey),
                  ),
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
