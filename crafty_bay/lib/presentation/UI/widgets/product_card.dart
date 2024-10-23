import 'package:crafty_bay/presentation/UI/screens/product_details_screen.dart';
import 'package:crafty_bay/presentation/utils/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/theme_colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key, required this.title, required this.price, required this.star, required this.image, required this.id,
  });
  final String title;
  final String price;
  final String star;
  final String image;
  final int id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() =>  ProductDetailsScreen(id: id,));
      },
      child: Card(
        color: Colors.white,
        child: SizedBox(
          width: 110,
          height: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 81,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: ThemeColor.lightAccentColor,
                  image:  DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,),
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
                        Icon(
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
                    Container(
                      height: 17,
                      width: 17,
                      decoration: BoxDecoration(
                        color: ThemeColor.accentColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.white,
                        size: 12,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
