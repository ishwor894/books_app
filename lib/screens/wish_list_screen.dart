import 'package:books_app/bloc/book_bloc.dart';
import 'package:books_app/bloc/book_event.dart';
import 'package:books_app/bloc/book_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({
    super.key,
  });

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('My Wishlist'),
        backgroundColor: Colors.grey.shade100,
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          final currentWishlist = state.wishlist;

          return currentWishlist.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: currentWishlist.length,
                  itemBuilder: (context, index) {
                    final book = currentWishlist[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        onTap: () {},
                        title: Text(
                          book.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          book.authorName?.join(", ") ?? "Unknown",
                          style: const TextStyle(color: Colors.black54),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          onPressed: () {
                            BlocProvider.of<BookBloc>(context).add(
                              RemoveFromWishlist(book),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${book.title} removed from wishlist!'),
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                )
              : _buildEmptyState(context);
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.bookmark_outline, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            'Your Wishlist is Empty',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Explore Books',
                style: TextStyle(color: Color(0xFF0046A0), fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
