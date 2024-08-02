import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'A Text is a widget in Flutter that allows us to display a string of text with a single line in our application. Depending on the layout constraints, we can break the string across multiple lines or might all be displayed on the same line. If we do not specify any styling to the text widget, it will use the closest DefaultTextStyle class style. This class does not have any explicit style.',
          textAlign: TextAlign.end,
          maxLines: 2,
          style: TextStyle(color: Colors.black,
          fontSize: 10,fontWeight: FontWeight.w600,
          backgroundColor: Colors.green
          ),
          overflow: TextOverflow.ellipsis,
        ),
      )
    );
  }
}
