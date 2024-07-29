import 'package:flutter/material.dart';
import 'package:taskmanager/style/style.dart';

ListView taskList(taskItems) {
  return ListView.builder(
      itemCount: taskItems.length,
      itemBuilder: (context, index) {
        return Card(
          child: itemSizedBox(
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(taskItems[index]['title'],style: head6Text(colorDarkBlue),),
                Text(
                taskItems[index]['description'],
                style: head7Text(colorLightGray),
              )
              ],
            )
          ),
        );
      });
}
