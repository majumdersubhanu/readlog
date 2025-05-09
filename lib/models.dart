import 'enums.dart';

class Book {
  String title;
  String author;
  BookStatus status;
  bool isFavourite;

  Book({
    required this.title,
    required this.author,
    required this.status,
    this.isFavourite = false,
  });
}
