import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/firestore_service.dart';

class PostBookScreen extends StatefulWidget {
  const PostBookScreen({super.key});

  @override
  State<PostBookScreen> createState() => _PostBookScreenState();
}

class _PostBookScreenState extends State<PostBookScreen> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _swapForController = TextEditingController();
  String _selectedCondition = 'Used';
  String? _imagePath;
  bool _isLoading = false;

  final List<String> _conditions = ['New', 'Like New', 'Good', 'Used'];

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _swapForController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (image != null) {
        setState(() {
          _imagePath = image.path;
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to pick image: $e');
    }
  }

  Future<void> _handlePost() async {
    if (_titleController.text.trim().isEmpty || _authorController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill in required fields');
      return;
    }

    setState(() => _isLoading = true);

    final firestoreService = Provider.of<FirestoreService>(context, listen: false);
    
    // Note: For simplicity, we're not uploading the image to Firebase Storage
    // In a production app, you would upload the image and get a URL
    final error = await firestoreService.createBook(
      title: _titleController.text.trim(),
      author: _authorController.text.trim(),
      condition: _selectedCondition,
      imageUrl: null, // Would be the uploaded image URL
      swapFor: _swapForController.text.trim().isEmpty ? null : _swapForController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (error == null) {
      Fluttertoast.showToast(
        msg: 'Book posted successfully!',
        backgroundColor: Colors.green,
      );
        if (!mounted) return;
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
        msg: error,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a Book'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Picker
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: _imagePath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          _imagePath!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_photo_alternate, size: 48, color: Colors.grey),
                              SizedBox(height: 8),
                              Text('Tap to add book cover'),
                            ],
                          ),
                        ),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_photo_alternate, size: 48, color: Colors.grey),
                          SizedBox(height: 8),
                          Text('Tap to add book cover'),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Book Title
            const Text(
              'Book Title *',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Enter book title',
              ),
            ),
            const SizedBox(height: 16),
            
            // Author
            const Text(
              'Author *',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _authorController,
              decoration: const InputDecoration(
                hintText: 'Enter author name',
              ),
            ),
            const SizedBox(height: 16),
            
            // Swap For
            const Text(
              'Swap For',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _swapForController,
              decoration: const InputDecoration(
                hintText: 'What would you like to swap for? (optional)',
              ),
            ),
            const SizedBox(height: 16),
            
            // Condition
            const Text(
              'Condition *',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _conditions.map((condition) {
                final isSelected = _selectedCondition == condition;
                return ChoiceChip(
                  label: Text(condition),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() => _selectedCondition = condition);
                  },
                  selectedColor: const Color(0xFFE8B834),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.black : Colors.grey[700],
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            
            // Post Button
            ElevatedButton(
              onPressed: _isLoading ? null : _handlePost,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text(
                      'Post',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
