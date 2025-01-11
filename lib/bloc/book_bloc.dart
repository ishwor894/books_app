import 'package:books_app/bloc/book_event.dart';
import 'package:books_app/bloc/book_state.dart';
import 'package:books_app/models/wishlist_model.dart';
import 'package:books_app/services/hive_service.dart';
import 'package:books_app/services/http_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookService bookService;
  final HiveService hiveService = HiveService();

  BookBloc({required this.bookService}) : super(BookState.initial()) {
    on<FetchWishlist>((event, emit) async {
      List<Wishlist> wishlist = await hiveService.fetchWishlist();
      emit(state.copyWith(wishlist: wishlist, wishlistUpdated: !state.wishlistUpdated));
    });
    on<FetchBooks>((event, emit) async {
      emit(state.copyWith(isLoading: true, loadingError: false));
      try {
        final books = await bookService.fetchBooks();
        emit(state.copyWith(
          books: books,
          isLoading: false,
        ));
      } catch (e) {
        emit(state.copyWith(loadingError: true, isLoading: false));
      }
    });

    on<AddToWishlist>((event, emit) async {
      // final updatedWishlist = List<Wishlist>.from(state.wishlist)
      //   ..add(event.book);
      await hiveService.saveWishlist(event.book);
      add(FetchWishlist());
      // emit(state.copyWith(wishlist: updatedWishlist));
    });

    on<RemoveFromWishlist>((event, emit) async {
      // final updatedWishlist = List<Wishlist>.from(state.wishlist)
      //   ..remove(event.book);
      await hiveService.removeWishlist(event.book);
      add(FetchWishlist());

      // emit(state.copyWith(wishlist: updatedWishlist));
    });
  }
}
