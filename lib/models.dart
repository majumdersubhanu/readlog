import 'enums.dart';

class Book {
  final String title;
  final String author;
  final BookStatus status;
  bool isFavourite;

  Book({
    required this.title,
    required this.author,
    required this.status,
    this.isFavourite = false,
  });
}
