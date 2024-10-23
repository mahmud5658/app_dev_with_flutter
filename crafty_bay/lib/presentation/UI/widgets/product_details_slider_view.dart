import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/presentation/utils/asset_paths.dart';
import 'package:crafty_bay/presentation/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class ProductDetailsSlideView extends StatelessWidget {
  const ProductDetailsSlideView({
    super.key, required this.imgURLs,
  });
  final List<String?> imgURLs;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> selectedIndex = ValueNotifier(0);
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            onPageChanged: (index, _) {
              selectedIndex.value = index;
            },
          ),
          items: imgURLs.map((img) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image:  DecorationImage(
                        image: NetworkImage(img??'https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                        fit: BoxFit.cover),
                    color: ThemeColor.lightGrey,
                  ),
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ValueListenableBuilder(
            builder: (context, index, _) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < imgURLs.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: index == i
                              ? ThemeColor.accentColor
                              : Colors.white,
                        ),
                      ),
                  ],
                ),
              );
            },
            valueListenable: selectedIndex,
          ),
        )
      ],
    );
  }
}
