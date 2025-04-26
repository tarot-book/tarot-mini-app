class Suit {
  final int id;
  final String name;
  final String genitive;
  

  Suit({
    required this.id,
    required this.name,
    required this.genitive,
    
  });

  factory Suit.fromJson(Map<String, dynamic> json) {
    return Suit(
      id: json['id'],
      name: json['name'],
      genitive: json['genitive'],
    );
  }
}
