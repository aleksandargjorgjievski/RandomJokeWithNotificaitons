import 'package:flutter/material.dart';
import 'package:random_jokes/models/joke_type_model.dart';
import 'package:random_jokes/widgets/jokeType//joke_type_card.dart';

class JokeTypeGrid extends StatelessWidget {
  final List<JokeType> jokeTypes;

  const JokeTypeGrid({Key? key, required this.jokeTypes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: jokeTypes.length,
      itemBuilder: (context, index) {
        return JokeTypeCard(jokeType: jokeTypes[index]);
      },
    );
  }
}