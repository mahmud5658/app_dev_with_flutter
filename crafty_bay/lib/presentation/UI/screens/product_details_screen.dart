import 'package:crafty_bay/data/model/add_to_cart.dart';
import 'package:crafty_bay/data/state_holders/create_cart_controller.dart';
import 'package:crafty_bay/data/state_holders/wishlist_addition_controller.dart';
import 'package:crafty_bay/presentation/UI/screens/email_identification_screen.dart';
import 'package:crafty_bay/presentation/UI/screens/review_screen.dart';
import 'package:crafty_bay/presentation/UI/widgets/bottom_popup_message.dart';
import 'package:crafty_bay/presentation/UI/widgets/button_loading_indicator.dart';
import 'package:crafty_bay/presentation/UI/widgets/loading_indicator.dart';
import 'package:crafty_bay/presentation/UI/widgets/product_details_slider_view.dart';
import 'package:crafty_bay/presentation/UI/widgets/size_picker.dart';
import 'package:crafty_bay/presentation/UI/widgets/text_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/state_holders/product_details_controller.dart';
import '../../utils/theme_colors.dart';
import '../widgets/icon_back_button.dart';
import '../widgets/product_amount_picker.dart';
import '../widgets/total_price_and_proceed.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.id});

  final int id;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _itemBuyingAmount = 01;
  String _size = 'X';
  String _color = 'Red';

  @override
  void initState() {
    Get.find<ProductDetailsController>()
        .getProductDetails(widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColor.lightGrey,
        leading: IconBackButton(whereToBack: () {
          Get.back();
        }),
        titleSpacing: 0,
        title: Text(
          'Product Details',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: GetBuilder<ProductDetailsController>(builder: (controller) {
        if (controller.errorMessage != null) {
          return Center(
            child: Text(controller.errorMessage!),
          );
        }
        return Visibility(
          visible: !controller.loading,
          replacement: const LoadingIndicator(),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductDetailsSlideView(
                        imgURLs: [
                          controller.productDetailsData?.img1,
                          controller.productDetailsData?.img2,
                          controller.productDetailsData?.img3,
                          controller.productDetailsData?.img4,
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _productNameAndAmountPicker(
                                context,
                                controller.productDetailsData?.product?.title ??
                                    'Error'),
                            _reviewSection(
                                context: context,
                                rating: controller
                                        .productDetailsData?.product?.star
                                        .toString() ??
                                    'Error',
                                productId: controller
                                        .productDetailsData?.productId
                                        .toString() ??
                                    '1'),
                            const SizedBox(
                              height: 15,
                            ),
                            TextColorPicker(
                                onSelectedColor: (String selectedColor) {
                                  _color = selectedColor;
                                },
                                availableColor: controller
                                        .productDetailsData?.color
                                        ?.split(',') ??
                                    []),
                            const SizedBox(
                              height: 15,
                            ),
                            SizePicker(
                              onSelectedSize: (String selectedSize) {
                                _size = selectedSize;
                              },
                              availableSizes: controller
                                      .productDetailsData?.size
                                      ?.split(',') ??
                                  [],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Description',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: ThemeColor.darkGrey),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              controller.productDetailsData?.des ?? 'Error',
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GetBuilder<CreateCartController>(builder: (controller) {
                return Visibility(
                  visible: !controller.loading,
                  replacement: const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: ButtonLoadingIndicator(),
                  ),
                  child: TotalPriceAndProceed(
                    totalPrice: int.parse(Get.find<ProductDetailsController>()
                                .productDetailsData
                                ?.product
                                ?.price ??
                            '0') *
                        _itemBuyingAmount,
                    buttonOnTap: () async {
                      bool check = await controller.createCart(AddToCart(
                          productId: widget.id,
                          color: _color,
                          size: _size,
                          qty: _itemBuyingAmount));
                      if (check) {
                        bottomPopUpMessage(
                            context, 'Added to the cart successfully!');
                      } else {
                        bottomPopUpMessage(
                            context, 'Please login to your profile!');
                        Get.to(() => const EmailIdentificationScreen());
                      }
                    },
                    buttonLabel: 'Add To Cart',
                  ),
                );
              })
            ],
          ),
        );
      }),
    );
  }

  Widget _reviewSection(
      {required BuildContext context,
      required String rating,
      required String productId}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.star,
          color: ThemeColor.secondColor,
          size: 18,
        ),
        Text(
          rating,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Colors.black54),
        ),
        const SizedBox(
          width: 6,
        ),
        InkWell(
          onTap: () {
            Get.to(() => const ReviewScreen());
          },
          child: Text(
            'Reviews',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: ThemeColor.accentColor),
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        InkWell(
          onTap: () async {
            bool added = await Get.find<WishlistAdditionController>()
                .addToWishList(productId: productId);
            if (added) {
              bottomPopUpMessage(context, 'Added to the wishlist!');
            } else {
              bottomPopUpMessage(context, 'You have to Login');
              Get.to(() => const EmailIdentificationScreen());
            }
          },
          child: GetBuilder<WishlistAdditionController>(builder: (controller) {
            return Visibility(
              visible: !controller.loading,
              replacement: const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              ),
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: ThemeColor.accentColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  Widget _productNameAndAmountPicker(
      BuildContext context, String productTitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            productTitle,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: ThemeColor.darkGrey),
          ),
        ),
        ProductAmountPicker(
          itemBuyingAmount: _itemBuyingAmount,
          plusButtonOnPressed: () {
            _itemBuyingAmount++;
            setState(() {});
          },
          minusButtonOnPressed: () {
            if (_itemBuyingAmount > 1) {
              _itemBuyingAmount--;
              setState(() {});
            }
          },
        )
      ],
    );
  }
}
