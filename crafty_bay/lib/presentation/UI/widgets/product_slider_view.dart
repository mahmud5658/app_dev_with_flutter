import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/data/state_holders/home_slider_controller.dart';
import 'package:crafty_bay/presentation/UI/widgets/loading_indicator.dart';
import 'package:crafty_bay/presentation/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductSlideView extends StatelessWidget {
  const ProductSlideView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> selectedIndex = ValueNotifier(0);
    return GetBuilder<HomeSliderController>(builder: (controller) {
      return Visibility(
        visible: !controller.loading,
        replacement: const LoadingIndicator(),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 16 / 8,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                viewportFraction: 1,
                onPageChanged: (index, _) {
                  selectedIndex.value = index;
                },
              ),
              items: controller.sliders.map((slider) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 7),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(slider.image ??
                                'https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                            fit: BoxFit.cover),
                        color: ThemeColor.accentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                slider.price ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: Colors.black54),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size.fromWidth(100),
                              ),
                              child: Text(
                                'Buy Now',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            ValueListenableBuilder(
              builder: (context, index, _) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < controller.sliders.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: index == i
                                ? ThemeColor.accentColor
                                : ThemeColor.midGrey,
                          ),
                        ),
                    ],
                  ),
                );
              },
              valueListenable: selectedIndex,
            )
          ],
        ),
      );
    });
  }
}
