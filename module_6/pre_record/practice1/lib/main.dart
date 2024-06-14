import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // application
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple)),
      home: const HomeActivity(),
    );
  }
}

class HomeActivity extends StatelessWidget {
  const HomeActivity({super.key});

  mySnackBar(message, context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Inventory',
          style: TextStyle(color: Colors.white),
        ),
        // titleSpacing: 0,
        centerTitle: false,
        toolbarHeight: 60,
        toolbarOpacity: 0.9,
        elevation: 6,

        actions: [
          IconButton(
              onPressed: () {
                mySnackBar('I am comment', context);
              },
              icon: const Icon(
                Icons.comment,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                mySnackBar('I am search', context);
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                mySnackBar('I am Settings', context);
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              )),
        ],
      ),
      body: const Text("Hello World"),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () {
          mySnackBar('Floating action Button', context);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Contact"),
        ],
        currentIndex: 0,
        onTap: (int index) {
          if (index == 0) {
            mySnackBar('I am Home Bottom Menu', context);
          }
          if (index == 1) {
            mySnackBar('I am profile bottom menu', context);
          }
          if(index==2){
             mySnackBar('I am contact bottom menu', context);
          }
        },
      ),
    );
  }
}
