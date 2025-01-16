import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:random_jokes/models/joke_type_model.dart';
import 'package:random_jokes/screens/favorite_jokes.dart';
import 'package:random_jokes/widgets/jokeType/joke_type_grid.dart';  // Fixed typo in import
import 'package:random_jokes/services/api_service.dart';
import 'package:random_jokes/screens/random_joke.dart';
import 'package:provider/provider.dart';
import 'package:random_jokes/provider/provider.dart';
import 'package:random_jokes/models/joke_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Joke> jokes = [];
  List<JokeType> jokeTypes = [];

  @override
  void initState() {
    super.initState();
    getJokeTypeFromAPI();
  }

  void getJokeTypeFromAPI() async {
    ApiService.getJokeTypes().then((response) {
      var data = List.from(json.decode(response.body));
      setState(() {
        jokeTypes = data.map<JokeType>((element) {
          return JokeType(type: element);
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use Provider to access the FavoritesProvider
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    // The favoriteJokes is now a list of the full Joke objects
    final favoriteJokes = favoritesProvider.favoriteJokes.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: Colors.white, size: 24)),
        title: const Text("Jokes App",
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RandomJokeScreen()));
              },
              icon: const Icon(Icons.lightbulb_outline,
                  color: Colors.white, size: 24))
        ],
      ),
      body: Stack(
        children: [
          JokeTypeGrid(jokeTypes: jokeTypes),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100.0), // Adjust the value to move up
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                onPressed: () {
                  // Navigate to the FavoriteJokeScreen and pass the list of favorite jokes
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FavoriteJokeScreen(
                              allJokes: favoriteJokes))); // Use the full Joke objects
                },
                icon: const Icon(Icons.star, color: Colors.white),
                label: const Text(
                  "Favorite Jokes",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
