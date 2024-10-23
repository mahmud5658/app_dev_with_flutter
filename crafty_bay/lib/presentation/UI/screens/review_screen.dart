import 'package:crafty_bay/presentation/UI/screens/create_review_screen.dart';
import 'package:crafty_bay/presentation/UI/widgets/icon_back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/theme_colors.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconBackButton(whereToBack: () {
          Get.back();
        }),
        title: Text(
          'Reviews',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Card(
                      shadowColor: ThemeColor.lightAccentColor,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: ThemeColor.lightGrey,
                                  foregroundColor: Colors.grey,
                                  child: Icon(Icons.person_outline_sharp),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Text('Momin Hosan',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black54),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('''I’m a sneaker head. I ordered the shoe twice and both times I received shoes that had been worn. I returned both pair back to Nike. Nike you can do better than sending long term customers shoes that have been previously worn.''',
                            style: Theme.of(context).textTheme.labelMedium,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 15,
                    );
                  },
                  itemCount: 3),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: const BoxDecoration(
                color: ThemeColor.lightAccentColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(33), topLeft: Radius.circular(33))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reviews (3)',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: ThemeColor.darkGrey),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: ThemeColor.accentColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: (){
                    Get.to(()=>const CreateReviewScreen());
                  },
                  icon: const Icon(Icons.add,)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
