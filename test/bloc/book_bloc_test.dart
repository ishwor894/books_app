import 'package:bloc_test/bloc_test.dart';
import 'package:books_app/bloc/book_bloc.dart';
import 'package:books_app/bloc/book_event.dart';
import 'package:books_app/bloc/book_state.dart';
import 'package:books_app/models/book_model.dart';
import 'package:books_app/services/http_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock of the BookService
class MockBookService extends Mock implements BookService {}

void main() {
  late MockBookService mockBookService;
  late BookBloc bookBloc;

  // sample for testing
  final sampleBooks = [
    Doc(
        title: "Book 1",
        authorName: ["Author A"],
        firstPublishYear: 2000,
        editionCount: 1,
        hasFulltext: true),
    Doc(
        title: "Book 2",
        authorName: ["Author B"],
        firstPublishYear: 2010,
        editionCount: 2,
        hasFulltext: false),
  ];

  setUp(() {
    mockBookService = MockBookService();
    bookBloc = BookBloc(bookService: mockBookService);
  });

  tearDown(() {
    bookBloc.close();
  });

  group('FetchBooks', () {
    blocTest<BookBloc, BookState>(
      'emits [isLoading: true, books: sampleBooks, isLoading: false] when FetchBooks is successful',
      build: () {
        when(() => mockBookService.fetchBooks())
            .thenAnswer((_) async => sampleBooks);
        return bookBloc;
      },
      act: (bloc) => bloc.add(FetchBooks()),
      expect: () => [
        BookState.initial().copyWith(isLoading: true),
        BookState.initial().copyWith(books: sampleBooks, isLoading: false),
      ],
    );

    blocTest<BookBloc, BookState>(
      'emits [isLoading: true, loadingError: true] when FetchBooks fails',
      build: () {
        when(() => mockBookService.fetchBooks())
            .thenThrow(Exception('Error fetching books'));
        return bookBloc;
      },
      act: (bloc) => bloc.add(FetchBooks()),
      expect: () => [
        BookState.initial().copyWith(isLoading: true),
        BookState.initial().copyWith(loadingError: true),
      ],
    );
  });

  group('AddToWishlist', () {
    blocTest<BookBloc, BookState>(
      'emits state with updated wishlist when a book is added',
      build: () => bookBloc,
      act: (bloc) => bloc.add(AddToWishlist(sampleBooks[0])),
      expect: () => [
        BookState.initial().copyWith(wishlist: [sampleBooks[0]]),
      ],
    );
  });

  group('RemoveFromWishlist', () {
    blocTest<BookBloc, BookState>(
      'emits state with updated wishlist when a book is removed',
      build: () {
        return BookBloc(bookService: mockBookService)
          ..emit(BookState.initial().copyWith(wishlist: [sampleBooks[0]]));
      },
      act: (bloc) => bloc.add(RemoveFromWishlist(sampleBooks[0])),
      expect: () => [
        BookState.initial().copyWith(wishlist: []),
      ],
    );
  });
}
