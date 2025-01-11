import 'package:books_app/models/book_model.dart';
import 'package:books_app/models/wishlist_model.dart';
import 'package:equatable/equatable.dart';

class BookState extends Equatable {
  final bool isLoading;  final bool wishlistUpdated;

  final bool loadingError;
  final List<Doc> books;
  final List<Wishlist> wishlist;
  const BookState(
      {required this.isLoading, required this.wishlistUpdated,
      required this.loadingError,
      required this.books,
      required this.wishlist});
  factory BookState.initial() {
    return const BookState(wishlistUpdated: false,
        books: [], wishlist: [], isLoading: false, loadingError: false);
  }
  BookState copyWith(
      {List<Doc>? books,
      List<Wishlist>? wishlist,
      bool? wishlistUpdated,
      bool? isLoading,
      bool? loadingError}) {
    return BookState(
      wishlistUpdated: wishlistUpdated??this.wishlistUpdated,
        books: books ?? this.books,
        wishlist: wishlist ?? this.wishlist,
        isLoading: isLoading ?? this.isLoading,
        loadingError: loadingError ?? this.loadingError);
  }

  @override
  List<Object?> get props => [books, wishlist,wishlistUpdated, isLoading, loadingError];
}
