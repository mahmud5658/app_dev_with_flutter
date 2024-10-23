import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/theme_colors.dart';
import '../screens/product_list_screen.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key, required this.title, required this.imageUrl, required this.id,
  });
  final String title;
  final String imageUrl;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){
            Get.to(() => ProductListScreen(
              categoryID: id, categoryName: title,
            ),);
          },
          child: Container(
            height: 70,
            width: 75,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: ThemeColor.lightAccentColor,
              image: DecorationImage(image: NetworkImage(imageUrl,
              ),
                fit: BoxFit.cover
              )
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ThemeColor.accentColor, fontSize: 12),
        )
      ],
    );
  }
}
