import 'package:crafty_bay/data/state_holders/product_list_by_remarks_controller.dart';
import 'package:crafty_bay/presentation/UI/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/icon_back_button.dart';
import '../widgets/product_card.dart';

class NewProductListScreen extends StatelessWidget {
  const NewProductListScreen({super.key});

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
          'New',
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
                    itemCount: controller.newProductList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5),
                    itemBuilder: (BuildContext context, int index) {
                      return  FittedBox(child: ProductCard(
                        id: controller.newProductList[index].id ?? 0,
                        title: controller.newProductList[index].title ?? 'Error',
                        price: controller.newProductList[index].price ?? '00',
                        star: controller.newProductList[index].star.toString(),
                        image: controller.newProductList[index].image ??
                            'https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      ),);
                    },
                  );
                } else {
                  return GridView.builder(
                    itemCount: controller.newProductList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5),
                    itemBuilder: (BuildContext context, int index) {
                      return  FittedBox(child: ProductCard(
                        id: controller.newProductList[index].id ?? 0,
                        title: controller.newProductList[index].title ?? 'Error',
                        price: controller.newProductList[index].price ?? '00',
                        star: controller.newProductList[index].star.toString(),
                        image: controller.newProductList[index].image ??
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
