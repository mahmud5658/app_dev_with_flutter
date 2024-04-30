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
                margin: EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    'Neymar is a Brazilian footballer known for his skill and flair. He played for Santos FC and Barcelona before joining Paris Saint-Germain. He\'s famous for his dribbling and goal-scoring ability.',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
