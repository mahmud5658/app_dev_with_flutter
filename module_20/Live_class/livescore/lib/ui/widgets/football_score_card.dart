import 'package:flutter/material.dart';
import 'package:todo/entities/football.dart';

class FootballScoredCard extends StatelessWidget {
  const FootballScoredCard({
    super.key, required this.football,
  });

  final Football football;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTeam(football.team1Score,football.team1Name),
            const Text('VS'),
             _buildTeam(football.team2Score,football.team2Name),
           
          ],
        ),
      ),
    );
  }

  Widget _buildTeam(int score,String teamName) {
    return Column(
            children: [
              Text(
                score.toString(),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              Text(
                teamName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              )
            ],
          );
  }
}
