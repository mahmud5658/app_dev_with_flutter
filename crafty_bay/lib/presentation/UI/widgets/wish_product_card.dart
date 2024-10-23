import 'package:crafty_bay/data/state_holders/wish_list_controller.dart';
import 'package:crafty_bay/data/state_holders/wish_list_item_delete_controller.dart';
import 'package:crafty_bay/presentation/UI/screens/email_identification_screen.dart';
import 'package:crafty_bay/presentation/UI/screens/product_details_screen.dart';
import 'package:crafty_bay/presentation/UI/widgets/bottom_popup_message.dart';
import 'package:crafty_bay/presentation/utils/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/theme_colors.dart';

class WishProductCard extends StatelessWidget {
  const WishProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.star,
    required this.image,
    required this.id,
  });

  final String title;
  final String price;
  final String star;
  final String image;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: SizedBox(
        width: 110,
        height: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.to(() => ProductDetailsScreen(
                      id: id,
                    ));
              },
              child: Container(
                height: 81,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: ThemeColor.lightAccentColor,
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                title,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Colors.black54),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$price\$',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: ThemeColor.accentColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: ThemeColor.secondColor,
                        size: 17,
                      ),
                      Text(
                        star,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: Colors.black54),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      bool check =
                          await Get.find<WishListItemDeleteController>()
                              .delete(productId: id.toString());
                      if (check) {
                        Get.find<WishListController>().getUserWishes();
                        bottomPopUpMessage(context, 'Delete');
                      } else {
                        bottomPopUpMessage(context, 'Please Login!');
                        Get.to(() => const EmailIdentificationScreen());
                      }
                    },
                    child: GetBuilder<WishListItemDeleteController>(
                        builder: (controller) {
                      return Visibility(
                        visible: !controller.loading,
                        replacement: Container(
                            height: 17,
                            width: 17,
                            decoration: BoxDecoration(
                              color: ThemeColor.accentColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(
                              Icons.refresh_rounded,
                              color: Colors.white,
                              size:12,
                            )),
                        child: Container(
                          height: 17,
                          width: 17,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      );
                    }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
