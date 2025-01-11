import 'package:books_app/models/wishlist_model.dart';

abstract class BookEvent {}

class FetchBooks extends BookEvent {}
class FetchWishlist extends BookEvent {}

class AddToWishlist extends BookEvent {
  final Wishlist book;
  AddToWishlist(this.book);
}

class RemoveFromWishlist extends BookEvent {
  final Wishlist book;
  RemoveFromWishlist(this.book);
}