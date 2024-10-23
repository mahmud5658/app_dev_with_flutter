import 'package:crafty_bay/presentation/UI/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/state_holders/product_list_by_category_controller.dart';
import '../../utils/theme_colors.dart';
import '../widgets/icon_back_button.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen(
      {super.key, required this.categoryID, required this.categoryName});

  final int categoryID;
  final String categoryName;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    Get.find<ProductListByCategoriesController>()
        .getProductListByCategory(widget.categoryID.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductListByCategoriesController>(builder: (controller) {
      return Visibility(
        visible: !controller.loading,
        replacement: const LoadingIndicator(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconBackButton(
              whereToBack: () {
                Get.back();
              },
            ),
            titleSpacing: 0,
            title: Text(
              widget.categoryName,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: LayoutBuilder(builder: (context, screen) {
              if (controller.productList.isNotEmpty) {
                if (screen.maxWidth < 300) {
                  return GridView.builder(
                    itemCount: controller.productList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5),
                    itemBuilder: (BuildContext context, int index) {
                      return FittedBox(
                        child: ProductCard(
                          id: controller.productList[index].id ?? 0,
                          title: controller.productList[index].title ?? 'Error',
                          price: controller.productList[index].price ?? '00',
                          star: controller.productList[index].star.toString(),
                          image: controller.productList[index].image ??
                              'https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                        ),
                      );
                    },
                  );
                } else {
                  return GridView.builder(
                    itemCount: controller.productList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5),
                    itemBuilder: (BuildContext context, int index) {
                      return FittedBox(
                        child: ProductCard(
                          id: controller.productList[index].id ?? 0,
                          title: controller.productList[index].title ?? 'Error',
                          price: controller.productList[index].price ?? '00',
                          star: controller.productList[index].star.toString(),
                          image: controller.productList[index].image ??
                              'https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                        ),
                      );
                    },
                  );
                }
              } else {
                return const Center(
                  child: Text(
                    'Empty',
                    style: TextStyle(
                      color: ThemeColor.darkGrey,
                      fontSize: 16,
                    ),
                  ),
                );
              }
            }),
          ),
        ),
      );
    });
  }
}
