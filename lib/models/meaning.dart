enum CardPosition {
  straight,
  reverted
}

/// A short meaning reference, typically used inside lists.
class CardMeaningRef {
  final int id; // unique meaning ID
  final CardPosition position; // card position (e.g. upright, reversed)
  final int source; // ID of the source of this meaning

  CardMeaningRef({required this.id, required this.position, required this.source});

  /// Creates a [CardMeaningRef] object from a JSON map
  factory CardMeaningRef.fromJson(Map<String, dynamic> json) => CardMeaningRef(
    id: json['id'],
    position: json['position'] == 'straight' ? CardPosition.straight : CardPosition.reverted,
    source: json['source'],
  );
}

/// Detailed Meaning record.
class CardMeaning extends CardMeaningRef {
  final String text;

  CardMeaning({required super.id, required super.position, required super.source, required this.text});
  
  /// Creates a [CardMeaning] object from a JSON map
  factory CardMeaning.fromJson(Map<String, dynamic> json) => CardMeaning(
    id: json['id'],
    position: json['position'] == 'straight' ? CardPosition.straight : CardPosition.reverted,
    source: json['source'],
    text: json['meaning']
  );
}

class CardMeanings {
  final CardMeaning? straight;
  final CardMeaning? reverted;

  CardMeanings({required this.straight, required this.reverted});
}

