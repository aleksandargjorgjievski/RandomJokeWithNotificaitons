import 'package:flutter/material.dart';

class DetailBackButton extends StatelessWidget {
  const DetailBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        backgroundColor: Colors.green,
        tooltip: 'Go back to previous screen',
        icon: const Icon(Icons.arrow_back, color: Colors.white,),
        label: const Text("Back", style: TextStyle(color: Colors.white),
        ));
  }
}
