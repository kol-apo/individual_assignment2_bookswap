import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/firestore_service.dart';

class EditBookScreen extends StatefulWidget {
  final Book book;
  
  const EditBookScreen({super.key, required this.book});

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _swapForController;
  late String _selectedCondition;
  String? _imagePath;
  bool _isLoading = false;

  final List<String> _conditions = ['New', 'Like New', 'Good', 'Used'];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _authorController = TextEditingController(text: widget.book.author);
    _swapForController = TextEditingController(text: widget.book.swapFor ?? '');
    _selectedCondition = widget.book.condition;
    _imagePath = widget.book.imageUrl;
  }

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

  Future<void> _handleUpdate() async {
    if (_titleController.text.trim().isEmpty || _authorController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill in required fields');
      return;
    }

    setState(() => _isLoading = true);

    final firestoreService = Provider.of<FirestoreService>(context, listen: false);
    
    final error = await firestoreService.updateBook(
      bookId: widget.book.id,
      title: _titleController.text.trim(),
      author: _authorController.text.trim(),
      condition: _selectedCondition,
      imageUrl: _imagePath,
      swapFor: _swapForController.text.trim().isEmpty ? null : _swapForController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (error == null) {
      Fluttertoast.showToast(
        msg: 'Book updated successfully!',
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
        title: const Text('Edit Book'),
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
                              Text('Tap to change book cover'),
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
            
            // Update Button
            ElevatedButton(
              onPressed: _isLoading ? null : _handleUpdate,
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
                      'Update',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
