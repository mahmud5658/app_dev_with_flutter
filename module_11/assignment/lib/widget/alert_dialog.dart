import 'package:assignment/Product/product_items.dart';
import 'package:flutter/material.dart';

class AlartDialog {
  static alertDialog(context, index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Expanded(
              child: AlertDialog(
            title: const Text(textAlign: TextAlign.center, "Congratulations!"),
            content: Text(
                textAlign: TextAlign.center,
                "You have added\n5\n${ProductItems.items[index]["title"]} on your bag!"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(219, 48, 34, 1),
                    foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 5),
                  ),
                  child: const Text("OKAY"))
            ],
          ));
        });
  }
}
