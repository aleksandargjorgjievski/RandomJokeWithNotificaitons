import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_jokes/models/joke_model.dart';
import 'package:random_jokes/provider/provider.dart';

class DetailData extends StatelessWidget {
  final int id;
  final List<Joke> jokes;

  const DetailData({super.key, required this.id, required this.jokes});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green[500], // Dark green background
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          height: 800, // Adjust the height as needed
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: jokes.length + 1,
            itemBuilder: (context, index) {
              if (index == jokes.length) {
                // Add an empty space at the end
                return const SizedBox(height: 200);
              }
              final joke = jokes[index];
              final isFavorite = favoritesProvider.isFavorite(joke);

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.green[600], // Lighter green for the joke item
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    joke.setup,
                    style: const TextStyle(
                      color: Colors.white, // White text for visibility
                      fontSize: 18,
                      fontWeight: FontWeight.w600, // Slightly bolder for setup
                    ),
                  ),
                  subtitle: Text(
                    joke.punchline,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7), // Punchline with slight opacity
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: Colors.yellow, // Yellow color for the star
                    ),
                    onPressed: () {
                      favoritesProvider.toggleFavorite(joke);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
