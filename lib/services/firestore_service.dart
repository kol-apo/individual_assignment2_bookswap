import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String condition;
  final String? imageUrl;
  final String userId;
  final String userEmail;
  final DateTime createdAt;
  final String? swapFor;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.condition,
    this.imageUrl,
    required this.userId,
    required this.userEmail,
    required this.createdAt,
    this.swapFor,
  });

  factory Book.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Book(
      id: doc.id,
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      condition: data['condition'] ?? 'Used',
      imageUrl: data['imageUrl'],
      userId: data['userId'] ?? '',
      userEmail: data['userEmail'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      swapFor: data['swapFor'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'condition': condition,
      'imageUrl': imageUrl,
      'userId': userId,
      'userEmail': userEmail,
      'createdAt': Timestamp.fromDate(createdAt),
      'swapFor': swapFor,
    };
  }
}

class FirestoreService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;
  String? get currentUserEmail => _auth.currentUser?.email;

  // Create a new book listing
  Future<String?> createBook({
    required String title,
    required String author,
    required String condition,
    String? imageUrl,
    String? swapFor,
  }) async {
    try {
      if (currentUserId == null) return 'User not authenticated';

      await _firestore.collection('books').add({
        'title': title,
        'author': author,
        'condition': condition,
        'imageUrl': imageUrl,
        'userId': currentUserId,
        'userEmail': currentUserEmail ?? '',
        'createdAt': FieldValue.serverTimestamp(),
        'swapFor': swapFor,
      });

      notifyListeners();
      return null; // Success
    } catch (e) {
      return 'Failed to create book listing: $e';
    }
  }

  // Get all book listings (Browse)
  Stream<List<Book>> getAllBooks() {
    return _firestore
        .collection('books')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Book.fromFirestore(doc)).toList());
  }

  // Get user's own book listings
  Stream<List<Book>> getUserBooks() {
    if (currentUserId == null) return Stream.value([]);

    return _firestore
        .collection('books')
        .where('userId', isEqualTo: currentUserId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Book.fromFirestore(doc)).toList());
  }

  // Update a book listing
  Future<String?> updateBook({
    required String bookId,
    required String title,
    required String author,
    required String condition,
    String? imageUrl,
    String? swapFor,
  }) async {
    try {
      await _firestore.collection('books').doc(bookId).update({
        'title': title,
        'author': author,
        'condition': condition,
        'imageUrl': imageUrl,
        'swapFor': swapFor,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      notifyListeners();
      return null; // Success
    } catch (e) {
      return 'Failed to update book: $e';
    }
  }

  // Delete a book listing
  Future<String?> deleteBook(String bookId) async {
    try {
      await _firestore.collection('books').doc(bookId).delete();
      notifyListeners();
      return null; // Success
    } catch (e) {
      return 'Failed to delete book: $e';
    }
  }

  // Get a single book by ID
  Future<Book?> getBookById(String bookId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('books').doc(bookId).get();
      if (doc.exists) {
        return Book.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Search books
  Stream<List<Book>> searchBooks(String query) {
    if (query.isEmpty) return getAllBooks();

    return _firestore
        .collection('books')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Book.fromFirestore(doc))
          .where((book) =>
              book.title.toLowerCase().contains(query.toLowerCase()) ||
              book.author.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
