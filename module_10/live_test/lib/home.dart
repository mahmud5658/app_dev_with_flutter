import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://assets.goal.com/images/v3/blt6e29869bfab4c3a8/Neymar.jpg?auto=webp&format=pjpg&width=1080&quality=60'))),
            ),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'Neymar JR',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
            Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  'neymarjonior@gmail.com',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                )),
                Container(
                margin: EdgeInsets.only(top: 15,right: 20,left: 20),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    
                    'Neymar da Silva Santos Júnior, commonly known as Neymar Jr., is a Brazilian professional footballer widely regarded as one of the most talented players of his generation. Born on February 5, 1992, in Mogi das Cruzes, São Paulo, Brazil, Neymar began his football career at a young age and quickly rose through the ranks to become a star player.',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
