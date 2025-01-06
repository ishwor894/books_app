import 'package:books_app/bloc/book_event.dart';
import 'package:books_app/bloc/book_state.dart';
import 'package:books_app/services/http_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/book_model.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookService bookService;

  BookBloc({required this.bookService}) : super(BookState.initial()) {
    on<FetchBooks>((event, emit) async {
      emit(state.copyWith(isLoading: true, loadingError: false));
      try {
        final books = await bookService.fetchBooks();
        emit(state.copyWith(books: books, isLoading: false));
      } catch (e) {
        emit(state.copyWith(loadingError: true, isLoading: false));
      }
    });

    on<AddToWishlist>((event, emit) {
      final updatedWishlist = List<Doc>.from(state.wishlist)..add(event.book);
      emit(state.copyWith(wishlist: updatedWishlist));
    });

    on<RemoveFromWishlist>((event, emit) {
      final updatedWishlist = List<Doc>.from(state.wishlist)
        ..remove(event.book);
      emit(state.copyWith(wishlist: updatedWishlist));
    });
  }
}
