import 'dart:convert';

class JokeType {
  final String type;

  JokeType({required this.type});

  JokeType.fromJson(Map<String, dynamic> data)
    :   type = data['type'];

  Map<String, dynamic> toJson() => {'type': type};
}

