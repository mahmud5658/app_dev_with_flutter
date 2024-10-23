import 'package:crafty_bay/data/state_holders/cart_delete_controller.dart';
import 'package:crafty_bay/data/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/data/state_holders/create_cart_controller.dart';
import 'package:crafty_bay/data/utils/server_urls.dart';
import 'package:crafty_bay/presentation/UI/screens/email_identification_screen.dart';
import 'package:crafty_bay/presentation/UI/widgets/bottom_popup_message.dart';
import 'package:crafty_bay/presentation/UI/widgets/button_loading_indicator.dart';
import 'package:crafty_bay/presentation/UI/widgets/icon_back_button.dart';
import 'package:crafty_bay/presentation/UI/widgets/loading_indicator.dart';
import 'package:crafty_bay/presentation/UI/widgets/product_amount_picker.dart';
import 'package:crafty_bay/presentation/UI/widgets/total_price_and_proceed.dart';
import 'package:crafty_bay/presentation/utils/asset_paths.dart';
import 'package:crafty_bay/presentation/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/model/add_to_cart.dart';
import '../../../data/model/cart.dart';
import '../../utils/navigation_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<void> _initializer() async {
    bool check = await Get.find<CartListController>().getCarts();
    if (check == false) {
      bottomPopUpMessage(context, 'Please Login!', showError: true);
      Get.to(() => const EmailIdentificationScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    _initializer();
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
          leading: IconBackButton(
            whereToBack: () {
              Get.find<NavigationController>().goToHomeScreen();
            },
          ),
          title: Text(
            'Cart',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        body: GetBuilder<CartListController>(builder: (controller) {
          return Visibility(
            visible: !controller.loading&&!Get.find<CreateCartController>().loading,
            replacement: const LoadingIndicator(),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Card(
                            shadowColor: ThemeColor.lightAccentColor,
                            color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          controller.carts[index].product
                                                  ?.image ??
                                              ServerURLSs.dummyImage,
                                        ),
                                        fit: BoxFit.cover),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                  height: 90,
                                  width: 90,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              controller.carts[index].product
                                                      ?.title ??
                                                  'Error',
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: Colors.black54),
                                            ),
                                          ),
                                          GetBuilder<CartDeleteController>(
                                              builder: (controller) {
                                            return Visibility(
                                              visible: !controller.loading,
                                              replacement: const Padding(
                                                padding: EdgeInsets.only(
                                                    top: 15, right: 15),
                                                child: SizedBox(
                                                    height: 15,
                                                    width: 15,
                                                    child:
                                                        CircularProgressIndicator()),
                                              ),
                                              child: IconButton(
                                                  onPressed: () async {
                                                    bool check = await controller
                                                        .deleteACart(
                                                            productId: Get.find<
                                                                    CartListController>()
                                                                .carts[index]
                                                                .productId
                                                                .toString());
                                                    if (check) {
                                                      bottomPopUpMessage(
                                                          context, 'Deleted');
                                                      _initializer();
                                                    } else {
                                                      bottomPopUpMessage(
                                                          context,
                                                          'Please Login!');
                                                      Get.to(
                                                          const EmailIdentificationScreen());
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.red,
                                                  )),
                                            );
                                          }),
                                        ],
                                      ),
                                      Text(
                                        'Color: ${controller.carts[index].color} Size: ${controller.carts[index].size}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$${controller.carts[index].price}',
                                            style: const TextStyle(
                                                color: ThemeColor.accentColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 6),
                                            child: ProductAmountPicker(
                                                itemBuyingAmount: int.parse(
                                                    controller
                                                            .carts[index].qty ??
                                                        '0'),
                                                plusButtonOnPressed: () async {
                                                  bool check = await Get.find<
                                                          CreateCartController>()
                                                      .createCart(
                                                    AddToCart(
                                                      productId: controller
                                                          .carts[index]
                                                          .productId,
                                                      color: controller
                                                          .carts[index].color,
                                                      size: controller
                                                          .carts[index].size,
                                                      qty: int.parse(controller
                                                                  .carts[index]
                                                                  .qty ??
                                                              '0') +
                                                          1,
                                                    ),
                                                  );
                                                  if (check) {
                                                    await controller.getCarts();
                                                  } else {
                                                    bottomPopUpMessage(context,
                                                        'Please login to your profile!');
                                                    Get.to(() =>
                                                        const EmailIdentificationScreen());
                                                  }
                                                },
                                                minusButtonOnPressed: () async {
                                                  if (int.parse(controller
                                                              .carts[index]
                                                              .qty ??
                                                          '1') >
                                                      1) {
                                                    bool check = await Get.find<
                                                            CreateCartController>()
                                                        .createCart(
                                                      AddToCart(
                                                        productId: controller
                                                            .carts[index]
                                                            .productId,
                                                        color: controller
                                                            .carts[index].color,
                                                        size: controller
                                                            .carts[index].size,
                                                        qty: int.parse(controller
                                                                    .carts[
                                                                        index]
                                                                    .qty ??
                                                                '0') -
                                                            1,
                                                      ),
                                                    );
                                                    if (check) {
                                                      await controller
                                                          .getCarts();
                                                    } else {
                                                      bottomPopUpMessage(
                                                          context,
                                                          'Please login to your profile!');
                                                      Get.to(() =>
                                                          const EmailIdentificationScreen());
                                                    }
                                                  }
                                                }),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 15,
                          );
                        },
                        itemCount: controller.carts.length),
                  ),
                ),
                TotalPriceAndProceed(
                    totalPrice: (controller.totalPrice),
                    buttonOnTap: () {},
                    buttonLabel: 'Checkout')
              ],
            ),
          );
        }),
      ),
    );
  }
}
