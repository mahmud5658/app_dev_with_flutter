import 'package:flutter/material.dart';

import '../utilities/app_colors.dart';

AppBar LocationTrackerAppBar(){
  return AppBar(
    backgroundColor: AppColors.themeColor,
    title: const Text('Real-Time Location Tracker',style: TextStyle(
      color: Colors.white
    ),),
  );
}