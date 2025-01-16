import 'package:flutter/material.dart';
import 'package:random_jokes/models/joke_model.dart';

class RandomJokeData extends StatelessWidget {
  final int id;
  final Joke joke;

  const RandomJokeData({super.key, required this.id, required this.joke});

  @override
  Widget build(BuildContext context) {
    final setup = joke.setup;
    final punchline = joke.punchline;

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green[500],
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 200, // Define the height explicitly
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Display the setup of the joke
            ListTile(
              title: Text(
                setup,
                textAlign: TextAlign.center, // Center the text
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              tileColor: Colors.redAccent[50],
            ),
            // Display the punchline of the joke with reduced opacity
            ListTile(
              title: Text(
                punchline,
                textAlign: TextAlign.center, // Center the text
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  // Make punchline less visible
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              tileColor: Colors.redAccent[50],
            ),
          ],
        ),
      ),
    );
  }
}