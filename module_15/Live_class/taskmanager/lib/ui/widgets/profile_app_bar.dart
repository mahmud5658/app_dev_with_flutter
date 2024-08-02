import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:taskmanager/ui/controller/auth_controller.dart';
import 'package:taskmanager/ui/screen/auth/signin_screen.dart';
import 'package:taskmanager/ui/screen/task/update_profile_screen.dart';
import 'package:taskmanager/ui/utility/color.dart';

AppBar profileAppBar(context, [bool fromUpdateProfile = false]) {
  return AppBar(
    backgroundColor: AppColor.themeColor,
    leading: Padding(
      padding:  const EdgeInsets.all(8.0),
      child: ClipOval(
        
        child: Image.memory(
          base64Decode(AuthController.userData?.photo ?? ''),
          height: 100,
          width: 100,
        ),
      ),
    ),
    title: GestureDetector(
      onTap: () {
        if (fromUpdateProfile) {
          return;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const UpdateProfileScreen()));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AuthController.userData!.fullName,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            AuthController.userData!.email ?? '',
            style: const TextStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
          onPressed: () async {
            await AuthController.clearAllData();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false);
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ))
    ],
  );
}
