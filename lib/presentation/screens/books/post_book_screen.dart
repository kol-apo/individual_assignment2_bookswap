import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/book_model.dart';

class PostBookScreen extends StatefulWidget {
  final Book? bookToEdit;

  const PostBookScreen({
    super.key,
    this.bookToEdit,
  });

  @override
  State<PostBookScreen> createState() => _PostBookScreenState();
}

class _PostBookScreenState extends State<PostBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  String _selectedCondition = 'New';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.bookToEdit != null) {
      _titleController.text = widget.bookToEdit!.title;
      _authorController.text = widget.bookToEdit!.author;
      _selectedCondition = widget.bookToEdit!.condition;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // TODO: Implement Firebase upload
    // - Upload image to Firebase Storage if selected
    // - Create/Update book document in Firestore
    
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.bookToEdit != null
                ? 'Book updated successfully'
                : 'Book posted successfully',
          ),
          backgroundColor: AppTheme.badgeGreen,
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    // TODO: Implement image picker
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image picker will be implemented with Firebase'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.bookToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Book' : 'Post a Book'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Book cover image picker
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryNavy.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.primaryNavy.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate,
                          size: 48,
                          color: AppTheme.primaryNavy.withOpacity(0.5),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Add Book Cover',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppTheme.primaryNavy.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Book title
                const Text(
                  'Book Title',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Enter book title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a book title';
                    }
                    if (value.length < AppConstants.minTitleLength) {
                      return 'Title must be at least ${AppConstants.minTitleLength} characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Author
                const Text(
                  'Author',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _authorController,
                  decoration: const InputDecoration(
                    hintText: 'Enter author name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the author name';
                    }
                    if (value.length < AppConstants.minAuthorLength) {
                      return 'Author must be at least ${AppConstants.minAuthorLength} characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Condition
                const Text(
                  'Condition',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: AppConstants.bookConditions.map((condition) {
                    final isSelected = _selectedCondition == condition;
                    return ChoiceChip(
                      label: Text(condition),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedCondition = condition;
                          });
                        }
                      },
                      selectedColor: AppTheme.accentGold,
                      labelStyle: TextStyle(
                        color: isSelected ? AppTheme.primaryNavy : null,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32),
                // Submit button
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSubmit,
                    child: _isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppTheme.primaryNavy,
                              ),
                            ),
                          )
                        : Text(isEditing ? 'Update Book' : 'Post'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
