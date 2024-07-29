import 'package:flutter/material.dart';
import 'package:taskmanager/style/style.dart';
import 'package:taskmanager/utility/utility.dart';

AppBar taskappBar(context, profileData) {
  return AppBar(
    backgroundColor: colorGreen,
    flexibleSpace: Container(
      margin: const EdgeInsets.fromLTRB(10, 40, 10, 5),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 24,
            child: ClipOval(
              child: Image.memory(showBase64Image(profileData['photo'].toString())),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${profileData['firstName']} ${profileData['lastName']}",
                style: head7Text(colorWhite),
              ),
              Text(
                '${profileData['email']}',
                style: head9Text(colorWhite),
              )
            ],
          )
        ],
      ),
    ),
    actions: [
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.add_circle_outline,
            color: colorWhite,
          )),
      IconButton(
          onPressed: () async {
            await removeToken();
            Navigator.pushNamedAndRemoveUntil(
                context, "/login", (route) => false);
          },
          icon: const Icon(
            Icons.output,
            color: colorWhite,
          )),
    ],
  );
}
