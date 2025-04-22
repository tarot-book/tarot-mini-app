import 'arcana_card_data.dart';

class MinorCard implements ArcanaCardData {
  final int id;
  final String name;
  final String image;

  MinorCard({
    required this.id,
    required this.name,
    required this.image,
  });

  factory MinorCard.fromJson(Map<String, dynamic> json) {
    return MinorCard(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  @override
  String get idStr => id.toString();

  @override
  String get title => name;

  @override
  String get imageUrl => image;
}
