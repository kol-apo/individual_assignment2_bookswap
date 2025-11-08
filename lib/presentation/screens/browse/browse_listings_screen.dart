import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/book_model.dart';
import '../../widgets/book_card.dart';
import '../books/book_details_screen.dart';

class BrowseListingsScreen extends StatefulWidget {
  const BrowseListingsScreen({super.key});

  @override
  State<BrowseListingsScreen> createState() => _BrowseListingsScreenState();
}

class _BrowseListingsScreenState extends State<BrowseListingsScreen> {
  // TODO: Replace with actual data from Firebase
  final List<Book> _dummyBooks = [
    Book(
      id: '1',
      title: 'Data Structures & Algorithms',
      author: 'Thomas H. Cormen',
      condition: 'Like New',
      coverImageUrl: null,
      ownerId: 'user1',
      ownerName: 'John Doe',
      status: 'available',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Book(
      id: '2',
      title: 'Operating Systems',
      author: 'Abraham Silberschatz',
      condition: 'Used',
      coverImageUrl: null,
      ownerId: 'user2',
      ownerName: 'Jane Smith',
      status: 'available',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Book(
      id: '3',
      title: 'Database Systems',
      author: 'Ramez Elmasri',
      condition: 'Good',
      coverImageUrl: null,
      ownerId: 'user3',
      ownerName: 'Mike Johnson',
      status: 'available',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Listings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
        ],
      ),
      body: _dummyBooks.isEmpty
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
                    'No books available',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _dummyBooks.length,
              itemBuilder: (context, index) {
                final book = _dummyBooks[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: BookCard(
                    book: book,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailsScreen(book: book),
                        ),
                      );
                    },
                    showSwapButton: true,
                  ),
                );
              },
            ),
    );
  }
}
