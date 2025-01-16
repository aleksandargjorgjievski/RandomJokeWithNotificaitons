import 'package:flutter/material.dart';
import 'package:random_jokes/models/joke_model.dart';
import 'package:random_jokes/services/api_service.dart';
import '../widgets/details/details_back_button.dart';
import '../widgets/details/details_data.dart';
import '../widgets/details/details_title.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  List<Joke> jokes = [];  // Default joke object
  String type = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    type = arguments['type']; // Assuming 'type' is passed as an argument
    print("Type: $type");
    if (type.isNotEmpty) {
      getJokesByType(type);  // Fetch the jokes by type
    }
  }

// Fetch jokes by type and select the first one
  void getJokesByType(String type) async {
    ApiService.getJokesByType(type).then((response) {
      print("response: $response");
      if (response.isNotEmpty) {
        setState(() {
          jokes = (response as List).map((jokeData) => Joke.fromJson(jokeData)).toList();  // Assuming the first joke is selected
        });
      }
    }).catchError((error) {
      print("Error: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(mainAxisSize: MainAxisSize.min,
          children: [
            DetailTitle(id: 1, type: type),
            DetailData(id: 1, jokes: jokes),
          ],
        ),
      ),
      floatingActionButton: const DetailBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }}