import 'package:crafty_bay/presentation/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class SizePicker extends StatefulWidget {
  const SizePicker(
      {super.key, required this.onSelectedSize, required this.availableSizes});

  @override
  State<SizePicker> createState() => _SizePickerState();
  final List<String> availableSizes;
  final Function(String) onSelectedSize;
}

class _SizePickerState extends State<SizePicker> {
  late String _selectedSize = widget.availableSizes.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w400,
                color: ThemeColor.darkGrey,
              ),
        ),
        Wrap(
          spacing: 6,
          children: widget.availableSizes.map((size) {
            return InkWell(
              onTap: () {
                _selectedSize = size;
                widget.onSelectedSize(size);
                setState(() {});
              },
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: _selectedSize == size
                          ? ThemeColor.accentColor
                          : ThemeColor.darkGrey,
                      width: 1),
                  borderRadius: BorderRadius.circular(100),
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
