import 'package:flutter/material.dart';

class Media extends StatelessWidget {
  const Media({super.key});

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size);
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).orientation);
    print(MediaQuery.of(context).devicePixelRatio);
    print(MediaQuery.of(context).displayFeatures);

    print(MediaQuery.displayFeaturesOf(context));
    print(MediaQuery.sizeOf(context));
    return Scaffold(
        appBar: AppBar(
            title: const Text('Media Query'),
            backgroundColor: Theme.of(context).primaryColor),
        // body: Center(
        //   child: Wrap(
        //     alignment: WrapAlignment.center,
        //     crossAxisAlignment: WrapCrossAlignment.end,
        //     spacing: 4,
        //     children: [
        //       Text(MediaQuery.of(context).orientation.toString()),
        //       Text(MediaQuery.of(context).orientation.toString()),
        //       Text(MediaQuery.of(context).orientation.toString()),
        //       Text(MediaQuery.of(context).orientation.toString()),
        //       Text(MediaQuery.of(context).orientation.toString()),
        //       Text(MediaQuery.of(context).orientation.toString()),
        //       Text(MediaQuery.of(context).orientation.toString()),
        //       Text(MediaQuery.of(context).orientation.toString()),
        //     ],
        //   ),

        // ),

        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth < 400) {
              return const Text('Mobile Devie');
            } else if (constraints.maxWidth < 600) {
              return const Text('Tablet Device');
            } else {
              return const Text('Web browser');
            }
          },
        ));
  }
}
