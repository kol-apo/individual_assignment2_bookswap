class Book {
  final String id;
  final String title;
  final String author;
  final String condition;
  final String ownerId;
  final String ownerName;
  final String status;
  final DateTime createdAt;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.condition,
    required this.ownerId,
    required this.ownerName,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'condition': condition,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Book.fromMap(Map<String, dynamic> map, String id) {
    return Book(
      id: id,
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      condition: map['condition'] ?? 'Used',
      ownerId: map['ownerId'] ?? '',
      ownerName: map['ownerName'] ?? '',
      status: map['status'] ?? 'available',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
