import 'package:flutter/material.dart';

enum BookStatus { reading, completed, wishList }

extension BookStatusExtension on BookStatus {
  Color get color {
    switch (this) {
      case BookStatus.reading:
        return Colors.blue;
      case BookStatus.completed:
        return Colors.green;
      case BookStatus.wishList:
        return Colors.orange;
    }
  }

  String get label {
    switch (this) {
      case BookStatus.reading:
        return 'Reading';
      case BookStatus.completed:
        return 'Completed';
      case BookStatus.wishList:
        return 'Wish List';
    }
  }
}
