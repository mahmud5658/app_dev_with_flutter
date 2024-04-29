import 'package:assignment/pages/content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(
                    Content.title[index],
                    style: const TextStyle(color: Colors.black, fontSize: 22),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Text(Content.description[index]),
                ),
                GestureDetector(
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * .95,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Center(
                          child: Text(
                        'See more',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Suggestion',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * .23,
                      width: MediaQuery.of(context).size.width * .43,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'https://static.independent.co.uk/2023/10/19/16/GettyImages-1702898339.jpg?quality=75&width=1250&crop=3%3A2%2Csmart&auto=webp',
                          ),
                        ),
                      ),
                      child: const Stack(
                        children: [
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Text(
                              'Casemiro',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * .23,
                      width: MediaQuery.of(context).size.width * .43,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://assets.goal.com/images/v3/bltcd8bcae793f700c7/GettyImages-1356696005.jpg?auto=webp&format=pjpg&width=1080&quality=60'),
                        ),
                      ),
                      child: const Stack(
                        children: [
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Text(
                              'Sadio mane',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height * .70,
                  width: MediaQuery.of(context).size.width * .45,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(Content.picture[index]))),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Content.title[index],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 22)),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(Content.description[index]),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(25)),
                            child: const Center(
                              child: Text(
                                'See more',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Suggestion',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height * .35,
                              width: MediaQuery.of(context).size.width * .20,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30),
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    'https://static.independent.co.uk/2023/10/19/16/GettyImages-1702898339.jpg?quality=75&width=1250&crop=3%3A2%2Csmart&auto=webp',
                                  ),
                                ),
                              ),
                              child: const Stack(
                                children: [
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: Text(
                                      'Casemiro',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height * .35,
                              width: MediaQuery.of(context).size.width * .20,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30),
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://assets.goal.com/images/v3/bltcd8bcae793f700c7/GettyImages-1356696005.jpg?auto=webp&format=pjpg&width=1080&quality=60'),
                                ),
                              ),
                              child: const Stack(
                                children: [
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: Text(
                                      'Sadio mane',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
      }),
    );
  }
}
