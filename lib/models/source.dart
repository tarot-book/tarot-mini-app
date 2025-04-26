class Source {
  final int id;
  final String name;
  

  Source({
    required this.id,
    required this.name,
    
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
    );
  }
}


class NoSourcesException implements Exception {
  @override
  String toString() => 'Empty sourcesd list.';
}
