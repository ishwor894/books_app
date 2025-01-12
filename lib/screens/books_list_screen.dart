import 'package:books_app/bloc/book_event.dart';
import 'package:books_app/bloc/book_state.dart';
import 'package:books_app/models/wishlist_model.dart';
import 'package:books_app/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../bloc/book_bloc.dart';
import 'book_details_screen.dart';

class BooksListScreen extends StatefulWidget {
  const BooksListScreen({super.key});

  @override
  State<BooksListScreen> createState() => _BooksListScreenState();
}

class _BooksListScreenState extends State<BooksListScreen> {
  @override
  Widget build(BuildContext context) {
    // Trigger the FetchBooks event
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<BookBloc>(context).add(FetchBooks());
    });
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          appBar: AppBar(
            backgroundColor: Colors.grey.shade300,
            title: const Text('Books'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const WishlistScreen(),
                    ),
                  );
                },
                icon: Badge(
                    smallSize: 10,
                    backgroundColor: state.wishlist.isNotEmpty
                        ? Colors.red
                        : Colors.transparent,
                    child: const Icon(Icons.card_giftcard_outlined)),
              ),
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, right: 20, left: 20),
              child: state.isLoading
                  ? _shimmersWidget(context)
                  : state.loadingError
                      ? _buildErrorState(context)
                      : ListView.builder(
                          itemCount: state.books.length,
                          itemBuilder: (context, index) {
                            final book = state.books[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 7,
                              margin: const EdgeInsets.symmetric(vertical: 10),
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
                                    color: Color(0xFF0046A0),
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  book.authorName?.join(", ") ??
                                      "Unknown Author",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: state.wishlist.contains(Wishlist(
                                          title: book.title,
                                          authorName: book.authorName))
                                      ? const Icon(Icons.favorite,
                                          color: Colors.red)
                                      : const Icon(Icons.favorite_border,
                                          color: Colors.grey),
                                  onPressed: () {
                                    if (state.wishlist.contains(Wishlist(
                                        title: book.title,
                                        authorName: book.authorName))) {
                                      BlocProvider.of<BookBloc>(context).add(
                                          RemoveFromWishlist(Wishlist(
                                              title: book.title,
                                              authorName: book.authorName)));
                                      _showSnackBar(
                                          context, 'Removed from wishlist!');
                                    } else {
                                      BlocProvider.of<BookBloc>(context).add(
                                          AddToWishlist(Wishlist(
                                              title: book.title,
                                              authorName: book.authorName)));
                                      _showSnackBar(
                                          context, 'Added to wishlist!');
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        )),
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

  // Widget _buildEmptyState(BuildContext context) {
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _shimmersWidget(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade500,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 100,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text('Shimmer'),
                    ),
                  );
                },
              )),
        ),
      ],
    );
  }
}
