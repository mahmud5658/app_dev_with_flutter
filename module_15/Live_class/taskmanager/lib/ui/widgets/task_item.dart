import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        title: Text('Title will be here'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description will be here'),
            Text(
              'Date: 12/12/24',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text('New'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                ),
                ButtonBar(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.delete)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
