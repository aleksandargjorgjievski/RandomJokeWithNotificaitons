import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://official-joke-api.appspot.com';

  static Future<http.Response> getJokeTypes() async {
    var response = await http.get(Uri.parse('$baseUrl/types'));
    print("Joke Types Response: ${response.body}");
    return response;
  }

  static Future<dynamic> getJokesByType(String type) async {
    final response = await http.get(Uri.parse('$baseUrl/jokes/$type/ten'));

    if (response.statusCode == 200) {
      print("Success: Jokes of type $type");
      var data = jsonDecode(response.body);
      print("Data: $data");
      return data;
    }
    else {
      throw Exception("Failed to load jokes of type $type!");
    }
  }

  static Future<dynamic> getRandomJoke() async {
    final response = await http.get(Uri.parse('$baseUrl/random_joke'));

    if (response.statusCode == 200) {
      print("Success: Random Joke");
      var data = jsonDecode(response.body);
      print("Data: $data");
      return data;
    }
    else {
      throw Exception("Failed to load random jokeType!");
    }
  }
}