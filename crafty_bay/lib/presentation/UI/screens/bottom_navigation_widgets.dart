import 'package:crafty_bay/data/state_holders/category_list_controller.dart';
import 'package:crafty_bay/data/state_holders/home_slider_controller.dart';
import 'package:crafty_bay/data/state_holders/product_list_by_remarks_controller.dart';
import 'package:crafty_bay/presentation/UI/screens/wish_list_screen.dart';
import 'package:crafty_bay/presentation/utils/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/theme_colors.dart';
import 'cart_screen.dart';
import 'categories_screen.dart';
import 'home_screen.dart';

class BottomNavigationWidgets extends StatefulWidget {
  const BottomNavigationWidgets({super.key});

  @override
  State<BottomNavigationWidgets> createState() =>
      _BottomNavigationWidgetsState();
}

class _BottomNavigationWidgetsState extends State<BottomNavigationWidgets> {
  final List<Widget> screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const CartScreen(),
    const WishListScreen(),
  ];

  void _initializer() {
    Get.find<HomeSliderController>().getHomeSliders();
    Get.find<CategoryListController>().getCategoryList();
    Get.find<ProductListByRemarksController>().getProductListByRemarks();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(builder: (context) {
      return Scaffold(
        body: RefreshIndicator(
            color: ThemeColor.accentColor,
            onRefresh: () async {
              _initializer();
            },
            child: screens[context.currentIndex]),
        bottomNavigationBar: BottomNavigationBar(
          onTap: context.selectIndex,
          currentIndex: context.currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 30,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.border_clear_rounded,
                  size: 28,
                ),
                label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: 28,
                ),
                label: 'Cart'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_border_rounded,
                  size: 28,
                ),
                label: 'Wish'),
          ],
        ),
      );
    });
  }
}
