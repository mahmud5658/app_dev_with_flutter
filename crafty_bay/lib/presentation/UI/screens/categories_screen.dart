import 'package:crafty_bay/data/state_holders/category_list_controller.dart';
import 'package:crafty_bay/presentation/UI/widgets/icon_back_button.dart';
import 'package:crafty_bay/presentation/UI/widgets/loading_indicator.dart';
import 'package:crafty_bay/presentation/utils/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/category_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (value, _) {
        Get.find<NavigationController>().goToHomeScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconBackButton(whereToBack: () {
            Get.find<NavigationController>().goToHomeScreen();
          }),
          titleSpacing: 0,
          title: Text(
            'Categories',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: GetBuilder<CategoryListController>(builder: (controller) {
            return Visibility(
              visible: !controller.loading,
              replacement: const LoadingIndicator(),
              child: LayoutBuilder(builder: (context, screen) {
                if (screen.maxWidth < 325 && screen.maxWidth >= 240) {
                  return GridView.builder(
                    itemCount: controller.categoryList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 0.8),
                    itemBuilder: (BuildContext context, int index) {
                      return CategoryCard(
                        id: controller.categoryList[index].id ?? 0,
                        title: controller.categoryList[index].categoryName ??
                            'Error',
                        imageUrl: controller.categoryList[index].categoryImg ??
                            'https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      );
                    },
                  );
                } else if (screen.maxWidth < 240) {
                  return GridView.builder(
                    itemCount: controller.categoryList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.8),
                    itemBuilder: (BuildContext context, int index) {
                      return CategoryCard(
                        id: controller.categoryList[index].id ?? 0,
                        title: controller.categoryList[index].categoryName ??
                            'Error',
                        imageUrl: controller.categoryList[index].categoryImg ??
                            'https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      );
                    },
                  );
                } else {
                  return GridView.builder(
                    itemCount: controller.categoryList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, childAspectRatio: 0.8),
                    itemBuilder: (BuildContext context, int index) {
                      return CategoryCard(
                        id: controller.categoryList[index].id ?? 0,
                        title: controller.categoryList[index].categoryName ??
                            'Error',
                        imageUrl: controller.categoryList[index].categoryImg ??
                            'https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      );
                    },
                  );
                }
              }),
            );
          }),
        ),
      ),
    );
  }
}
