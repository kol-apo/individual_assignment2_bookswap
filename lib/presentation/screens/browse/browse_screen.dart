import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/book_model.dart';
import '../my_listings/my_listings_screen.dart';
import '../chats/chats_screen.dart';
import '../settings/settings_screen.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  int _currentIndex = AppConstants.navBrowse;

  final List<Widget> _screens = const [
    BrowseListingsTab(),
    MyListingsScreen(),
    ChatsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            activeIcon: Icon(Icons.library_books),
            label: 'My Listings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class BrowseListingsTab extends StatefulWidget {
  const BrowseListingsTab({super.key});

  @override
  State<BrowseListingsTab> createState() => _BrowseListingsTabState();
}

class _BrowseListingsTabState extends State<BrowseListingsTab> {
  // Dummy data for demonstration
  final List<Book> _dummyBooks = [
    Book(
      id: '1',
      title: 'Data Structures & Algorithms',
      author: 'Thomas H. Cormen',
      condition: 'Like New',
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
      ownerId: 'user3',
      ownerName: 'Mike Johnson',
      status: 'available',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  Color _getConditionColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'new':
      case 'like new':
        return AppTheme.badgeGreen;
      case 'good':
        return AppTheme.badgeOrange;
      case 'used':
        return AppTheme.badgeGray;
      default:
        return AppTheme.badgeGray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Listings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
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
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBrown,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.menu_book,
                            size: 40,
                            color: AppTheme.accentGold,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                book.author,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.textSecondary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getConditionColor(book.condition),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  book.condition,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 36,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Swap feature coming soon!'),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Swap',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
