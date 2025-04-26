import 'package:tarot_mini_app/models/arcana_type.dart';
import 'package:tarot_mini_app/models/card.dart';


class MajorCard implements ArcanaCardData {
  final int _id;
  final String name;
  final String orgname;
  final String image;
  final int number;

  MajorCard({
    required int id,
    required this.name,
    required this.orgname,
    required this.image,
    required this.number
  }) : _id = id;

  factory MajorCard.fromJson(Map<String, dynamic> json) {
    return MajorCard(
      id: json['id'],
      name: json['name'],
      orgname: json['orgname'],
      image: json['image'],
      number: json['number']
    );
  }

  @override
  int get id => _id;

  @override
  String get title => '$number. $name';

  @override
  String get imageUrl => image;

  @override
  ArcanaType get arcana => ArcanaType.major;
}
