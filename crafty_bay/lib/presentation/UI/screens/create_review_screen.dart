import 'package:crafty_bay/presentation/utils/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/app_logo.dart';
import '../widgets/icon_back_button.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconBackButton(whereToBack: () {
          Get.back();
        }),
        title: Text(
          'Create Review',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.sizeOf(context).height / 10,
              left: 26,
              right: 26,
              bottom: 26),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? i) {
                    if (i != null) {
                      if (i.trim().isEmpty) {
                        return 'Kindly enter your first name!';
                      }
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: 'First Name'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? i) {
                    if (i != null) {
                      if (i.trim().isEmpty) {
                        return 'Kindly enter your last name!';
                      }
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: 'Last Name'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? i) {
                    if (i != null) {
                      if (i.trim().isEmpty) {
                        return 'Kindly share your review!';
                      }
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  maxLines: 4,
                  keyboardType: TextInputType.text,
                  decoration:
                  const InputDecoration(hintText: 'Write Review'),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                  },
                  child: Text(
                    'Submit',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //---------------------------------------Functions---------------------------------------

  //---------------------------------------Variable----------------------------------------
}
