import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/book_model.dart';
import '../../widgets/book_card.dart';
import '../books/post_book_screen.dart';

class MyListingsScreen extends StatefulWidget {
  const MyListingsScreen({super.key});

  @override
  State<MyListingsScreen> createState() => _MyListingsScreenState();
}

class _MyListingsScreenState extends State<MyListingsScreen> {
  // TODO: Replace with actual user's books from Firebase
  final List<Book> _myBooks = [
    Book(
      id: '4',
      title: 'Computer Networks',
      author: 'Andrew S. Tanenbaum',
      condition: 'Good',
      coverImageUrl: null,
      ownerId: 'currentUser',
      ownerName: 'Current User',
      status: 'available',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  void _handleDelete(Book book) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Book'),
        content: Text('Are you sure you want to delete "${book.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Delete from Firebase
              setState(() {
                _myBooks.removeWhere((b) => b.id == book.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Book deleted successfully'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _handleEdit(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostBookScreen(bookToEdit: book),
      ),
    ).then((updated) {
      if (updated == true) {
        // Refresh the list
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Listings'),
      ),
      body: _myBooks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.book_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No books listed yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the + button to post a book',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _myBooks.length,
              itemBuilder: (context, index) {
                final book = _myBooks[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: BookCard(
                    book: book,
                    onTap: () {},
                    showEditButton: true,
                    onEdit: () => _handleEdit(book),
                    onDelete: () => _handleDelete(book),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PostBookScreen(),
            ),
          ).then((added) {
            if (added == true) {
              // Refresh the list
              setState(() {});
            }
          });
        },
        backgroundColor: AppTheme.accentGold,
        child: const Icon(
          Icons.add,
          color: AppTheme.primaryNavy,
        ),
      ),
    );
  }
}
