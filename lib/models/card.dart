// Общий интерфейс для всех карт
abstract class FullCardData {
  int get id;
  int get deckId;
  String get name;
  String get imageUrl;
  List<CardMeaning> get meanings;
}

// Общая модель значений
class CardMeaning {
  final int id;
  final String position;
  final int source;

  CardMeaning({
    required this.id,
    required this.position,
    required this.source,
  });

  factory CardMeaning.fromJson(Map<String, dynamic> json) => CardMeaning(
        id: json['id'],
        position: json['position'],
        source: json['source'],
      );
}

// Старший аркан
class MajorCardDetail implements FullCardData {
  final int id;
  final int deck;
  final String image;
  final String name;
  final String orgname;
  final int number;
  final List<CardMeaning> meanings;

  MajorCardDetail({
    required this.id,
    required this.deck,
    required this.image,
    required this.name,
    required this.orgname,
    required this.number,
    required this.meanings,
  });

  factory MajorCardDetail.fromJson(Map<String, dynamic> json) => MajorCardDetail(
        id: json['id'],
        deck: json['deck'],
        image: json['image'],
        name: json['name'],
        orgname: json['orgname'],
        number: json['number'],
        meanings: (json['meanings'] as List)
            .map((m) => CardMeaning.fromJson(m))
            .toList(),
      );

  @override
  int get deckId => deck;

  @override
  String get imageUrl => image;
}

// Младший аркан
class MinorCardDetail implements FullCardData {
  final int id;
  final int deck;
  final String image;
  final String name;
  final int rank;
  final int suit;
  final List<CardMeaning> meanings;

  MinorCardDetail({
    required this.id,
    required this.deck,
    required this.image,
    required this.name,
    required this.rank,
    required this.suit,
    required this.meanings,
  });

  factory MinorCardDetail.fromJson(Map<String, dynamic> json) => MinorCardDetail(
        id: json['id'],
        deck: json['deck'],
        image: json['image'],
        name: json['name'],
        rank: json['rank'],
        suit: json['suit'],
        meanings: (json['meanings'] as List)
            .map((m) => CardMeaning.fromJson(m))
            .toList(),
      );

  @override
  int get deckId => deck;

  @override
  String get imageUrl => image;
}
