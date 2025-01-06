import 'package:books_app/models/book_model.dart';

abstract class BookEvent {}

class FetchBooks extends BookEvent {}

class AddToWishlist extends BookEvent {
  final Doc book;
  AddToWishlist(this.book);
}

class RemoveFromWishlist extends BookEvent {
  final Doc book;
  RemoveFromWishlist(this.book);
}