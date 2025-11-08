class Book {
  final String id;
  final String title;
  final String author;
  final String condition;
  final String? coverImageUrl;
  final String ownerId;
  final String ownerName;
  final String status;
  final DateTime createdAt;
  final String? swapOfferId;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.condition,
    this.coverImageUrl,
    required this.ownerId,
    required this.ownerName,
    required this.status,
    required this.createdAt,
    this.swapOfferId,
  });

  // Convert to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'condition': condition,
      'coverImageUrl': coverImageUrl,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'swapOfferId': swapOfferId,
    };
  }

  // Create from Firebase Map
  factory Book.fromMap(Map<String, dynamic> map, String id) {
    return Book(
      id: id,
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      condition: map['condition'] ?? 'Used',
      coverImageUrl: map['coverImageUrl'],
      ownerId: map['ownerId'] ?? '',
      ownerName: map['ownerName'] ?? '',
      status: map['status'] ?? 'available',
      createdAt: DateTime.parse(map['createdAt']),
      swapOfferId: map['swapOfferId'],
    );
  }

  // Create a copy with updated fields
  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? condition,
    String? coverImageUrl,
    String? ownerId,
    String? ownerName,
    String? status,
    DateTime? createdAt,
    String? swapOfferId,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      condition: condition ?? this.condition,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      ownerId: ownerId ?? this.ownerId,
      ownerName: ownerName ?? this.ownerName,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      swapOfferId: swapOfferId ?? this.swapOfferId,
    );
  }
}
