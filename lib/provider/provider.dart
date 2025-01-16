import 'package:flutter/material.dart';
import 'package:random_jokes/models/joke_model.dart';

class FavoritesProvider with ChangeNotifier {
  // Store the whole Joke object in a Set
  final Set<Joke> _favoriteJokes = {};

  Set<Joke> get favoriteJokes => _favoriteJokes;

  // Toggle favorite status for a joke
  void toggleFavorite(Joke joke) {
    if (_favoriteJokes.contains(joke)) {
      _favoriteJokes.remove(joke);
    } else {
      _favoriteJokes.add(joke);
    }
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  // Check if a joke is a favorite
  bool isFavorite(Joke joke) {
    return _favoriteJokes.contains(joke);
  }
}
