enum CardPosition {
  straight,
  reverted
}

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