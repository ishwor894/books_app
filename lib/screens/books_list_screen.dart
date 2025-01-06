import 'package:books_app/bloc/book_event.dart';
import 'package:books_app/bloc/book_state.dart';
import 'package:books_app/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/book_bloc.dart';
import 'book_details.dart';

class BooksListScreen extends StatelessWidget {
  const BooksListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Books'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WishlistScreen(
                        wishlist: state.wishlist,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.card_giftcard_outlined),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.loadingError
                    ? _buildErrorState(context)
                    : state.books.isNotEmpty
                        ? ListView.builder(
                            itemCount: state.books.length,
                            itemBuilder: (context, index) {
                              final book = state.books[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 4,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => BookDetailsScreen(
                                          book: book,
                                        ),
                                      ),
                                    );
                                  },
                                  title: Text(
                                    book.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    book.authorName?.join(", ") ??
                                        "Unknown Author",
                                    style:
                                        const TextStyle(color: Colors.black54),
                                  ),
                                  trailing: IconButton(
                                    icon: state.wishlist.contains(book)
                                        ? const Icon(Icons.favorite,
                                            color: Colors.red)
                                        : const Icon(Icons.favorite_border,
                                            color: Colors.grey),
                                    onPressed: () {
                                      if (state.wishlist.contains(book)) {
                                        BlocProvider.of<BookBloc>(context)
                                            .add(RemoveFromWishlist(book));
                                        _showSnackBar(
                                            context, 'Removed from wishlist!');
                                      } else {
                                        BlocProvider.of<BookBloc>(context)
                                            .add(AddToWishlist(book));
                                        _showSnackBar(
                                            context, 'Added to wishlist!');
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                          )
                        : _buildEmptyState(context),
          ),
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.book_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            'Oops!! Something went wrong.',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () =>
                BlocProvider.of<BookBloc>(context).add(FetchBooks()),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.book_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            'No books available now!',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () =>
                BlocProvider.of<BookBloc>(context).add(FetchBooks()),
            child: const Text('Load Books'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
