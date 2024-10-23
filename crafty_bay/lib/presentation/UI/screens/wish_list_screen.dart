import 'package:crafty_bay/data/state_holders/wish_list_controller.dart';
import 'package:crafty_bay/data/utils/server_urls.dart';
import 'package:crafty_bay/presentation/UI/widgets/icon_back_button.dart';
import 'package:crafty_bay/presentation/UI/widgets/loading_indicator.dart';
import 'package:crafty_bay/presentation/UI/widgets/wish_product_card.dart';
import 'package:crafty_bay/presentation/utils/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/theme_colors.dart';
import '../widgets/bottom_popup_message.dart';
import '../widgets/product_card.dart';
import 'email_identification_screen.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  Future<void> _initializer() async {
    bool check = await Get.find<WishListController>().getUserWishes();
    if (check == false) {
      bottomPopUpMessage(context, 'Please Login!', showError: true);
      Get.to(() => const EmailIdentificationScreen());
    }
  }

  @override
  void initState() {
    _initializer();
    super.initState();
  }

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
            'Wish List',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        body: GetBuilder<WishListController>(builder: (controller) {
          return Visibility(
            visible: !controller.loading,
            replacement: const LoadingIndicator(),
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: LayoutBuilder(builder: (context, screen) {
                if (controller.wishList.isNotEmpty) {
                  if (screen.maxWidth < 331) {
                    return GridView.builder(
                      itemCount: controller.wishList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5),
                      itemBuilder: (BuildContext context, int index) {
                        return FittedBox(
                          child: WishProductCard(
                            title: controller.wishList[index].product?.title ??
                                'Error',
                            price: controller.wishList[index].product?.price ??
                                'Error',
                            star: controller.wishList[index].product?.star
                                    .toString() ??
                                '0',
                            image: controller.wishList[index].product?.image ??
                                ServerURLSs.dummyImage,
                            id: controller.wishList[index].productId ?? 0,
                          ),
                        );
                      },
                    );
                  } else {
                    return GridView.builder(
                      itemCount: controller.wishList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5),
                      itemBuilder: (BuildContext context, int index) {
                        return FittedBox(
                          child: WishProductCard(
                            title: controller.wishList[index].product?.title ??
                                'Error',
                            price: controller.wishList[index].product?.price ??
                                'Error',
                            star: controller.wishList[index].product?.star
                                    .toString() ??
                                '0',
                            image: controller.wishList[index].product?.image ??
                                ServerURLSs.dummyImage,
                            id: controller.wishList[index].productId ?? 0,
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
          );
        }),
      ),
    );
  }
}
