import 'package:flutter/material.dart';
import '../../utils/theme_colors.dart';

class TotalPriceAndProceed extends StatelessWidget {
  const TotalPriceAndProceed({
    super.key,
    required this.totalPrice,
    required this.buttonOnTap,
    required this.buttonLabel,
  });

  final int totalPrice;
  final VoidCallback buttonOnTap;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
          color: ThemeColor.lightAccentColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(33), topLeft: Radius.circular(33))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: ThemeColor.darkGrey),
              ),
              Text(
                '\$$totalPrice',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: ThemeColor.accentColor),
              )
            ],
          ),
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(fixedSize: const Size.fromWidth(140)),
            onPressed: buttonOnTap,
            child: Text(
              buttonLabel,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
