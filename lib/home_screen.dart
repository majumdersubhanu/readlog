import 'package:flutter/material.dart';

import 'enums.dart';
import 'mock_books.dart';
import 'models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Book> _bookList = mockBooks;

  final _titleController = TextEditingController();
  final _authorController = TextEditingController();

  BookStatus? _statusFilter;
  BookStatus? _dialogStatus;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final books = _getFilteredBooks();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Books'),
        forceMaterialTransparency: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(68),
          child: _buildSearchBar(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBookDialog,
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterChips(),
          Expanded(
            child:
                books.isEmpty
                    ? const Center(
                      child: Text('No books found. Tap + to add one.'),
                    )
                    : ListView.builder(
                      itemCount: books.length,
                      itemBuilder:
                          (context, index) =>
                              _buildBookCard(books[index], index),
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard(Book book, int index) {
    return GestureDetector(
      onLongPress: () => _showEditBookDialog(editableBook: book, index: index),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              book.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.author,
                  style: const TextStyle(color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Chip(
                  label: Text(book.status.label),
                  backgroundColor: book.status.color.withValues(alpha: 0.1),
                  shape: StadiumBorder(
                    side: BorderSide(color: book.status.color),
                  ),
                ),
              ],
            ),
            trailing: Wrap(
              spacing: 8,
              children: [
                IconButton(
                  icon: Icon(
                    book.isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: book.isFavourite ? Colors.red : null,
                  ),
                  onPressed: () {
                    // isFavourite = true -> false and vice versa
                    setState(() => book.isFavourite = !book.isFavourite);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() => _bookList.removeAt(index));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 8,
        // Takes in a function with the particular object as an argument, and returns a widget for each object.
        children:
            BookStatus.values.map((status) {
              final isSelected = _statusFilter == status;
              return ChoiceChip(
                label: Text(status.label),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _statusFilter = selected ? status : null;
                  });
                },
              );
            }).toList(),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Search books by name or author...',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (value) => setState(() => _searchQuery = value),
      ),
    );
  }

  void _clearForm() {
    _titleController.clear();
    _authorController.clear();
    _dialogStatus = null;
  }

  /// [List<Book>] explicitly
  /// returns a list of books.
  List<Book> _getFilteredBooks() {
    return _bookList.where((book) {
      final matchesStatus =
          _statusFilter == null || book.status == _statusFilter;
      final matchesSearch =
          _searchQuery.isEmpty ||
          book.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          book.author.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesStatus && matchesSearch;
    }).toList();
  }

  void _showAddBookDialog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Add a Book'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Book Title'),
                ),
                TextField(
                  controller: _authorController,
                  decoration: const InputDecoration(labelText: 'Author'),
                ),
                DropdownButtonFormField<BookStatus>(
                  value: _dialogStatus,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items:
                      BookStatus.values.map((status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Text(status.label),
                        );
                      }).toList(),
                  onChanged: (value) => setState(() => _dialogStatus = value),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _clearForm();
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_titleController.text.isEmpty ||
                        _authorController.text.isEmpty ||
                        _dialogStatus == null) {
                      return;
                    }
                    _bookList.add(
                      Book(
                        title: _titleController.text,
                        author: _authorController.text,
                        status: _dialogStatus!,
                      ),
                    );
                  });

                  _clearForm();
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }

  void _showEditBookDialog({required Book editableBook, required int index}) {
    _titleController.text = editableBook.title;
    _authorController.text = editableBook.author;
    _dialogStatus = editableBook.status;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Edit Book'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Book Title'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _authorController,
                decoration: const InputDecoration(labelText: 'Author'),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<BookStatus>(
                value: _dialogStatus,
                decoration: const InputDecoration(labelText: 'Status'),
                items:
                    BookStatus.values.map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(status.label),
                      );
                    }).toList(),
                onChanged: (value) => setState(() => _dialogStatus = value),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _clearForm();
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isEmpty ||
                    _authorController.text.isEmpty ||
                    _dialogStatus == null) {
                  return;
                }
                setState(() {
                  _bookList[index] = Book(
                    title: _titleController.text,
                    author: _authorController.text,
                    status: _dialogStatus!,
                    isFavourite: _bookList[index].isFavourite,
                  );
                });

                _clearForm();
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
