import 'dart:math';

import 'enums.dart';
import 'models.dart';

final mockBooks = [
  Book(
    title: 'To Kill a Mockingbird',
    author: 'Harper Lee',
    status: randomStatus(),
  ),
  Book(title: '1984', author: 'George Orwell', status: randomStatus()),
  Book(
    title: 'Pride and Prejudice',
    author: 'Jane Austen',
    status: randomStatus(),
  ),
  Book(
    title: 'The Great Gatsby',
    author: 'F. Scott Fitzgerald',
    status: randomStatus(),
  ),
  Book(title: 'Moby-Dick', author: 'Herman Melville', status: randomStatus()),
  Book(title: 'War and Peace', author: 'Leo Tolstoy', status: randomStatus()),
  Book(
    title: 'The Catcher in the Rye',
    author: 'J.D. Salinger',
    status: randomStatus(),
  ),
  Book(
    title: 'The Lord of the Rings',
    author: 'J.R.R. Tolkien',
    status: randomStatus(),
  ),
  Book(title: 'Jane Eyre', author: 'Charlotte Brontë', status: randomStatus()),
  Book(
    title: 'Crime and Punishment',
    author: 'Fyodor Dostoevsky',
    status: randomStatus(),
  ),
  Book(
    title: 'Brave New World',
    author: 'Aldous Huxley',
    status: randomStatus(),
  ),
  Book(
    title: 'The Brothers Karamazov',
    author: 'Fyodor Dostoevsky',
    status: randomStatus(),
  ),
  Book(
    title: 'Wuthering Heights',
    author: 'Emily Brontë',
    status: randomStatus(),
  ),
  Book(title: 'The Odyssey', author: 'Homer', status: randomStatus()),
  Book(title: 'The Iliad', author: 'Homer', status: randomStatus()),
];

final _random = Random();

BookStatus randomStatus() {
  final length = BookStatus.values.length;
  final index = _random.nextInt(length);
  return BookStatus.values[index];
}
