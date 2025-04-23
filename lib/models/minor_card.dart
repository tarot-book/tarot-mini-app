

import 'package:tarot_mini_app/models/card.dart';

class MinorCard implements ArcanaCardData {
  final int _id;
  final String name;
  final String image;

  MinorCard({
    required int id,
    required this.name,
    required this.image,
  }) : _id = id;

  factory MinorCard.fromJson(Map<String, dynamic> json) {
    return MinorCard(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  @override
  int get id => _id;

  @override
  String get title => name;

  @override
  String get imageUrl => image;
}
