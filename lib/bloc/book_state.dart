import 'package:books_app/models/book_model.dart';
import 'package:equatable/equatable.dart';

class BookState extends Equatable {
  final bool isLoading;
  final bool loadingError;
  final List<Doc> books;
  final List<Doc> wishlist;
  const BookState(
      {required this.isLoading,
      required this.loadingError,
      required this.books,
      required this.wishlist});
  factory BookState.initial() {
    return const BookState(
        books: [], wishlist: [], isLoading: false, loadingError: false);
  }
  BookState copyWith(
      {List<Doc>? books,
      List<Doc>? wishlist,
      bool? isLoading,
      bool? loadingError}) {
    return BookState(
        books: books ?? this.books,
        wishlist: wishlist ?? this.wishlist,
        isLoading: isLoading ?? this.isLoading,
        loadingError: loadingError ?? this.loadingError);
  }

  @override
  List<Object?> get props => [books, wishlist, isLoading, loadingError];
}
