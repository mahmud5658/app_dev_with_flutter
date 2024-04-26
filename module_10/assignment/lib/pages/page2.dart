

import 'package:assignment/pages/content.dart';
import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  final int index;
  const Page2({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Content.name[index],
            style: const TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(8),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.white38, borderRadius: BorderRadius.circular(10)),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
        ),
        actions: const [
          Icon(
            Icons.more_vert,
            color: Colors.white,
            size: 30,
          )
        ],
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height * .35,
                    width: MediaQuery.of(context).size.width * .90,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                            image: NetworkImage(Content.picture[index]))),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  margin: const EdgeInsets.only(left: 25),
                  child: Text(Content.title[index],style: const TextStyle(color: Colors.black,fontSize: 22),
                  ),
                ),Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * .90,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: const Center(child: Text('See more',style: TextStyle(color: Colors.white,fontSize: 20),)),
                  ),
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
