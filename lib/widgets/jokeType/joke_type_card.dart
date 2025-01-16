import 'package:flutter/material.dart';
import 'package:random_jokes/models/joke_type_model.dart';

class JokeTypeCard extends StatelessWidget {
  final JokeType jokeType;

  const JokeTypeCard({Key? key, required this.jokeType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/details',
          arguments: {'type': jokeType.type}, // Pass the joke type as an argument
        );
      },
      borderRadius: BorderRadius.circular(15), // Adds ripple effect matching the border
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.greenAccent,
                Colors.green,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.category_outlined,
                size: 50,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Text(
                jokeType.type.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}