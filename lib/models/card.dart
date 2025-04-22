// Lightweight interface for displaying cards in grid/list
abstract class ArcanaCardData {
  String get idStr;      // unique identifier (as string)
  String get title;      // card title to show in thumbnails
  String get imageUrl;   // image URL for preview
}

// Common interface for all detailed card types
abstract class FullCardData {
  int get id;
  int get deckId;
  String get name;
  String get imageUrl;
  List<CardMeaning> get meanings;
}

// Shared model for card meanings
class CardMeaning {
  final int id;             // unique meaning ID
  final String position;    // card position (e.g. upright, reversed)
  final int source;         // ID of the source of this meaning

  CardMeaning({
    required this.id,
    required this.position,
    required this.source,
  });

  /// Creates a [CardMeaning] object from a JSON map
  factory CardMeaning.fromJson(Map<String, dynamic> json) => CardMeaning(
        id: json['id'],
        position: json['position'],
        source: json['source'],
      );
}

// Detailed model for Major Arcana card
class MajorCardDetail implements FullCardData {
  final int id;                // card ID
  final int deck;              // deck ID
  final String image;          // URL to card image
  final String name;           // localized card name
  final String orgname;        // original name (e.g. French)
  final int number;            // Major Arcana number (0-21)
  final List<CardMeaning> meanings; // interpretations

  MajorCardDetail({
    required this.id,
    required this.deck,
    required this.image,
    required this.name,
    required this.orgname,
    required this.number,
    required this.meanings,
  });

  /// Creates a [MajorCardDetail] object from a JSON map
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

  /// Returns the deck ID in the format required by [FullCardData]
  @override
  int get deckId => deck;

  /// Returns the image URL in the format required by [FullCardData]
  @override
  String get imageUrl => image;
}

// Detailed model for Minor Arcana card
class MinorCardDetail implements FullCardData {
  final int id;                // card ID
  final int deck;              // deck ID
  final String image;          // URL to card image
  final String name;           // card name
  final int rank;              // card rank (e.g. 1 = Ace)
  final int suit;              // card suit (e.g. 1 = Wands)
  final List<CardMeaning> meanings; // interpretations

  MinorCardDetail({
    required this.id,
    required this.deck,
    required this.image,
    required this.name,
    required this.rank,
    required this.suit,
    required this.meanings,
  });

  /// Creates a [MinorCardDetail] object from a JSON map
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

  /// Returns the deck ID in the format required by [FullCardData]
  @override
  int get deckId => deck;

  /// Returns the image URL in the format required by [FullCardData]
  @override
  String get imageUrl => image;
}
