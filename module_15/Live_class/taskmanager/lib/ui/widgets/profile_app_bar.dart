import 'package:flutter/material.dart';
import 'package:taskmanager/ui/utility/color.dart';
import 'package:taskmanager/ui/widgets/network_cached_image.dart';

AppBar profileAppBar() {
  return AppBar(
    backgroundColor: AppColor.themeColor,
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 10,
        child: NetworkCachedImage(url: ''),
      ),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Abdullah Al Mahmud',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        Text(
          'abdullah@gmail.com',
          style: TextStyle(
              fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ],
    ),
    actions: [
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ))
    ],
  );
}
