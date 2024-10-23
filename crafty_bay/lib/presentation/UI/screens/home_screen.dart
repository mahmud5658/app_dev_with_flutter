import 'package:crafty_bay/data/model/create_profile_data.dart';
import 'package:crafty_bay/data/state_holders/category_list_controller.dart';
import 'package:crafty_bay/data/state_holders/product_list_by_remarks_controller.dart';
import 'package:crafty_bay/data/state_holders/profile_info_cache_controller.dart';
import 'package:crafty_bay/data/state_holders/token_controller.dart';
import 'package:crafty_bay/presentation/UI/screens/email_identification_screen.dart';
import 'package:crafty_bay/presentation/UI/screens/popular_product_list_screen.dart';
import 'package:crafty_bay/presentation/UI/screens/product_list_screen.dart';
import 'package:crafty_bay/presentation/UI/screens/set_profile.dart';
import 'package:crafty_bay/presentation/UI/screens/special_product_list_screen.dart';
import 'package:crafty_bay/presentation/UI/widgets/bottom_popup_message.dart';
import 'package:crafty_bay/presentation/UI/widgets/loading_indicator.dart';
import 'package:crafty_bay/presentation/utils/asset_paths.dart';
import 'package:crafty_bay/presentation/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/navigation_controller.dart';
import '../widgets/category_card.dart';
import '../widgets/product_card.dart';
import '../widgets/product_slider_view.dart';
import '../widgets/section_title.dart';
import 'package:get/get.dart';

import 'new_product_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          AssetPaths.navLogo,
          height: 30,
        ),
        actions: [
          _appBarButton(
              icon: Icons.person_outline,
              onTap: () async {
                String? accessToken = await TokenController.getToken();
                if (accessToken != null) {
                  Get.to(
                      SetProfile(
                      heading: 'Update Profile',
                       readProfileData: await ProfileInfoCacheController.getProfile(),
                    ),
                  );
                } else {
                  bottomPopUpMessage(context, 'Please Login!');
                  Get.to(()=>
                    const EmailIdentificationScreen(),
                  );
                }
              }),
          _appBarButton(icon: Icons.phone_outlined, onTap: () {}),
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: _appBarButton(
                icon: Icons.notifications_active_outlined, onTap: () {}),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: _searchTextField(),
              ),
              const ProductSlideView(),
              SectionTitle(
                title: 'All Categories',
                onTap: () {
                  Get.find<NavigationController>().goToCategoryScreen();
                },
              ),
              const SizedBox(
                height: 15,
              ),
              _categoriesSection(),
              SizedBox(
                height: 15,
              ),
              SectionTitle(
                  title: 'Popular',
                  onTap: () {
                    Get.to(() => const PopularProductListScreen());
                  }),
              SizedBox(
                height: 15,
              ),
              _popularProductSection(),
              SizedBox(
                height: 15,
              ),
              SectionTitle(
                  title: 'Spacial',
                  onTap: () {
                    Get.to(() => const SpecialProductListScreen());
                  }),
              SizedBox(
                height: 15,
              ),
              _specialProductSection(),
              SizedBox(
                height: 15,
              ),
              SectionTitle(
                  title: 'New',
                  onTap: () {
                    Get.to(() => const NewProductListScreen());
                  }),
              SizedBox(
                height: 15,
              ),
              _newProductSection(),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //---------------------------------------Widgets---------------------------------------
  Widget _appBarButton({required IconData icon, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: CircleAvatar(
        backgroundColor: ThemeColor.lightGrey,
        foregroundColor: ThemeColor.darkGrey,
        child: IconButton(onPressed: onTap, icon: Icon(icon)),
      ),
    );
  }

  Widget _categoriesSection() {
    return SizedBox(
      height: 91,
      child: GetBuilder<CategoryListController>(builder: (controller) {
        return Visibility(
          visible: !controller.loading,
          replacement: const LoadingIndicator(),
          child: ListView.separated(
            itemBuilder: (context, i) {
              return CategoryCard(
                title: controller.categoryList[i].categoryName ?? 'Error',
                imageUrl: controller.categoryList[i].categoryImg ??
                    'https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                id: controller.categoryList[i].id ?? 0,
              );
            },
            separatorBuilder: (context, i) {
              return const SizedBox(
                width: 16,
              );
            },
            itemCount: controller.categoryList.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      }),
    );
  }

  Widget _popularProductSection() {
    return SizedBox(
      height: 130,
      child: GetBuilder<ProductListByRemarksController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.loading,
            replacement: const LoadingIndicator(),
            child: ListView.separated(
              itemBuilder: (context, i) {
                return ProductCard(
                  id: controller.popularProductList[i].id ?? 0,
                  title: controller.popularProductList[i].title ?? 'Error',
                  price: controller.popularProductList[i].price ?? '00',
                  star: controller.popularProductList[i].star.toString(),
                  image: controller.popularProductList[i].image ??
                      'https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                );
              },
              separatorBuilder: (context, i) {
                return const SizedBox(
                  width: 5,
                );
              },
              itemCount: controller.popularProductList.length,
              scrollDirection: Axis.horizontal,
            ),
          );
        },
      ),
    );
  }

  Widget _newProductSection() {
    return SizedBox(
      height: 130,
      child: GetBuilder<ProductListByRemarksController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.loading,
            replacement: const LoadingIndicator(),
            child: ListView.separated(
              itemBuilder: (context, i) {
                return ProductCard(
                  title: controller.newProductList[i].title ?? 'Error',
                  price: controller.newProductList[i].price ?? '00',
                  star: controller.newProductList[i].star.toString(),
                  image: controller.newProductList[i].image ??
                      'https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  id: controller.newProductList[i].id ?? 0,
                );
              },
              separatorBuilder: (context, i) {
                return const SizedBox(
                  width: 5,
                );
              },
              itemCount: controller.newProductList.length,
              scrollDirection: Axis.horizontal,
            ),
          );
        },
      ),
    );
  }

  Widget _specialProductSection() {
    return SizedBox(
      height: 130,
      child: GetBuilder<ProductListByRemarksController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.loading,
            replacement: const LoadingIndicator(),
            child: ListView.separated(
              itemBuilder: (context, i) {
                return ProductCard(
                  id: controller.specialProductList[i].id ?? 0,
                  title: controller.specialProductList[i].title ?? 'Error',
                  price: controller.specialProductList[i].price ?? '00',
                  star: controller.specialProductList[i].star.toString(),
                  image: controller.specialProductList[i].image ??
                      'https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                );
              },
              separatorBuilder: (context, i) {
                return const SizedBox(
                  width: 5,
                );
              },
              itemCount: controller.specialProductList.length,
              scrollDirection: Axis.horizontal,
            ),
          );
        },
      ),
    );
  }

  Widget _searchTextField() {
    return TextField(
      style:
          Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        fillColor: ThemeColor.lightGrey,
        filled: true,
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: ThemeColor.darkGrey,
        ),
        hintText: 'Search',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(
            color: ThemeColor.accentColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
