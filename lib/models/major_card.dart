import 'arcana_card_data.dart';

class MajorCard implements ArcanaCardData {
  final int id;
  final String name;
  final String orgname;
  final String image;

  MajorCard({
    required this.id,
    required this.name,
    required this.orgname,
    required this.image,
  });

  factory MajorCard.fromJson(Map<String, dynamic> json) {
    return MajorCard(
      id: json['id'],
      name: json['name'],
      orgname: json['orgname'],
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
