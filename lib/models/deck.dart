class Deck {
  final int id;
  final String name;
  final String image;
  final String description;
  

  Deck({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    
  });

  factory Deck.fromJson(Map<String, dynamic> json) {
    return Deck(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
    );
  }
}
