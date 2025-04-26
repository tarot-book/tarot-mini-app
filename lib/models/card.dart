// Lightweight interface for displaying cards in grid/list
import 'package:tarot_mini_app/models/arcana_type.dart';
import 'package:tarot_mini_app/models/meaning.dart';

abstract class ArcanaCardData {
  int get id; // unique identifier
  String get title; // card title to show in thumbnails
  String get imageUrl; // image URL for preview
  ArcanaType get arcana; // Type of Arcana
}

// Common interface for all detailed card types
abstract class FullCardData {
  int get id;
  int get deckId;
  String get name;
  String get imageUrl;
  ArcanaType get arcana; // Type of Arcana
  List<CardMeaningRef> get meanings;
}

// Shared model for card meanings references (usually, in a list)


// Detailed model for Major Arcana card
class MajorCardDetail implements FullCardData {
  final int _id; // card ID
  final int deck; // deck ID
  final String image; // URL to card image
  final String _name; // localized card name
  final String orgname; // original name (e.g. French)
  final int number; // Major Arcana number (0-21)
  final List<CardMeaningRef> _meanings; // interpretations

  MajorCardDetail({
    required  int id,
    required this.deck,
    required this.image,
    required String name,
    required this.orgname,
    required this.number,
    required List<CardMeaningRef> meanings,
  }) : _id = id, _name = name, _meanings = meanings;

  /// Creates a [MajorCardDetail] object from a JSON map
  factory MajorCardDetail.fromJson(Map<String, dynamic> json) =>
      MajorCardDetail(
        id: json['id'],
        deck: json['deck'],
        image: json['image'],
        name: json['name'],
        orgname: json['orgname'],
        number: json['number'],
        meanings:
            (json['meanings'] as List)
                .map((m) => CardMeaningRef.fromJson(m))
                .toList(),
      );

  /// Returns the deck ID in the format required by [FullCardData]
  @override
  int get deckId => deck;

  /// Returns the image URL in the format required by [FullCardData]
  @override
  String get imageUrl => image;
  
  @override
  int get id => _id;
  
  @override
  List<CardMeaningRef> get meanings => _meanings;
  
  @override
  String get name => _name;

  @override
  ArcanaType get arcana => ArcanaType.major;
}

// Detailed model for Minor Arcana card
class MinorCardDetail implements FullCardData {
  final int _id; // card ID
  final int deck; // deck ID
  final String image; // URL to card image
  final String _name; // card name
  final int rank; // card rank (e.g. 1 = Ace)
  final int suit; // card suit (e.g. 1 = Wands)
  final List<CardMeaningRef> _meanings; // interpretations

  MinorCardDetail({
    required int id,
    required this.deck,
    required this.image,
    required String name,
    required this.rank,
    required this.suit,
    required  List<CardMeaningRef> meanings,
  })  : _id = id,
        _name = name,
        _meanings = meanings;

  /// Creates a [MinorCardDetail] object from a JSON map
  factory MinorCardDetail.fromJson(Map<String, dynamic> json) =>
      MinorCardDetail(
        id: json['id'],
        deck: json['deck'],
        image: json['image'],
        name: json['name'],
        rank: json['rank'],
        suit: json['suit'],
        meanings:
            (json['meanings'] as List)
                .map((m) => CardMeaningRef.fromJson(m))
                .toList(),
      );

  /// Returns the deck ID in the format required by [FullCardData]
  @override
  int get deckId => deck;

  /// Returns the image URL in the format required by [FullCardData]
  @override
  String get imageUrl => image;
  
  @override
  int get id => _id;
  
  @override
  List<CardMeaningRef> get meanings => _meanings;
  
  @override
  String get name => _name;

  @override
  ArcanaType get arcana => ArcanaType.minor;  
}
