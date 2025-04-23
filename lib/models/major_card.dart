import 'package:tarot_mini_app/models/card.dart';


class MajorCard implements ArcanaCardData {
  final int _id;
  final String name;
  final String orgname;
  final String image;

  MajorCard({
    required int id,
    required this.name,
    required this.orgname,
    required this.image,
  }) : _id = id;

  factory MajorCard.fromJson(Map<String, dynamic> json) {
    return MajorCard(
      id: json['id'],
      name: json['name'],
      orgname: json['orgname'],
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
