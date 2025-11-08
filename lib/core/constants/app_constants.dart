class AppConstants {
  // Book conditions
  static const List<String> bookConditions = [
    'New',
    'Like New',
    'Good',
    'Used',
  ];

  // Swap status
  static const String statusAvailable = 'available';
  static const String statusPending = 'pending';
  static const String statusAccepted = 'accepted';
  static const String statusRejected = 'rejected';

  // Navigation
  static const int navBrowse = 0;
  static const int navMyListings = 1;
  static const int navChats = 2;
  static const int navSettings = 3;

  // Validation
  static const int minTitleLength = 2;
  static const int minAuthorLength = 2;
}
