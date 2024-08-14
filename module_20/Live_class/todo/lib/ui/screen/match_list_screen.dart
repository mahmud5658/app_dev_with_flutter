import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/entities/football.dart';
import 'package:todo/ui/widgets/football_score_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Football> matchList = [];

  Future<void> _getFootballMatch() async {
    final QuerySnapshot result =
        await firebaseFirestore.collection('football').get();

    for (QueryDocumentSnapshot doc in result.docs) {
      matchList.add(Football(
          matchName: doc.id,
          team1Name: doc.get('team1Name'),
          team2Name: doc.get('team2Name'),
          team1Score: doc.get('team1'),
          team2Score: doc.get('team2')));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getFootballMatch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football'),
      ),
      body: StreamBuilder(
        stream: firebaseFirestore.collection('football').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData == false) {
            return Center(
              child: Text('Empty'),
            );
          }
          matchList.clear();
         for (QueryDocumentSnapshot doc in snapshot.data?.docs??[]) {
            matchList.add(Football(
                matchName: doc.id,
                team1Name: doc.get('team1Name'),
                team2Name: doc.get('team2Name'),
                team1Score: doc.get('team1'),
                team2Score: doc.get('team2')));
          }
          return ListView.builder(
              itemCount: matchList.length,
              itemBuilder: (context, index) {
                return FootballScoredCard(
                  football: matchList[index],
                );
              });
        },
      ),
    );
  }
}
