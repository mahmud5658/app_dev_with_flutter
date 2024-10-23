import 'package:crafty_bay/data/state_holders/product_list_by_remarks_controller.dart';
import 'package:crafty_bay/presentation/UI/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/icon_back_button.dart';
import '../widgets/product_card.dart';

class PopularProductListScreen extends StatelessWidget {
  const PopularProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconBackButton(
          whereToBack: () {
            Get.back();
          },
        ),
        titleSpacing: 0,
        title: Text(
          'Popular',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: GetBuilder<ProductListByRemarksController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.loading,
            replacement: const LoadingIndicator(),
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: LayoutBuilder(builder: (context, screen) {
                if (screen.maxWidth < 300) {
                  return GridView.builder(
                    itemCount: controller.popularProductList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5),
                    itemBuilder: (BuildContext context, int index) {
                      return  FittedBox(child: ProductCard(
                        id: controller.popularProductList[index].id ?? 0,
                        title: controller.popularProductList[index].title ?? 'Error',
                        price: controller.popularProductList[index].price ?? '00',
                        star: controller.popularProductList[index].star.toString(),
                        image: controller.popularProductList[index].image ??
                            'https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      ),);
                    },
                  );
                } else {
                  return GridView.builder(
                    itemCount: controller.popularProductList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5),
                    itemBuilder: (BuildContext context, int index) {
                      return  FittedBox(child: ProductCard(
                        id: controller.popularProductList[index].id ?? 0,
                        title: controller.popularProductList[index].title ?? 'Error',
                        price: controller.popularProductList[index].price ?? '00',
                        star: controller.popularProductList[index].star.toString(),
                        image: controller.popularProductList[index].image ??
                            'https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      ),);
                    },
                  );
                }
              }),
            ),
          );
        }
      ),
    );
  }
}
