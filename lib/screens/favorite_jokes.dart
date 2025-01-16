import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_jokes/models/joke_model.dart';
import 'package:random_jokes/provider/provider.dart';

class FavoriteJokeScreen extends StatelessWidget {
  final List<Joke> allJokes;

  const FavoriteJokeScreen({super.key, required this.allJokes});

  @override
  Widget build(BuildContext context) {
    print("All jokes $allJokes");
    // Access the FavoritesProvider from the context
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    // Filter out the favorite jokes using the FavoritesProvider
    final favoriteJokes = allJokes.where((joke) => favoritesProvider.isFavorite(joke)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jokes', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      backgroundColor: Colors.black,
      body: favoriteJokes.isEmpty
          ? const Center(child: Text('No favorite jokes yet!', style: TextStyle(color: Colors.white),))
          : ListView.builder(
        itemCount: favoriteJokes.length,
        itemBuilder: (context, index) {
          final joke = favoriteJokes[index];
          return ListTile(
            title: Text(joke.setup, style: TextStyle(color: Colors.white, fontSize: 20),),
            subtitle: Text(joke.punchline, style: TextStyle(color: Colors.white54),),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle_outline, color: Colors.white,),
              onPressed: () {
                // Remove joke from favorites
                favoritesProvider.toggleFavorite(joke);
              },
            ),
          );
        },
      ),
    );
  }
}
