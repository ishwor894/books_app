import 'package:books_app/bloc/book_bloc.dart';
import 'package:books_app/bloc/book_event.dart';
import 'package:books_app/bloc/book_state.dart';
import 'package:books_app/models/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/book_model.dart';

class BookDetailsScreen extends StatefulWidget {
  final Doc book;

  const BookDetailsScreen({
    super.key,
    required this.book,
  });

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          appBar: AppBar(
            title: Text(
              widget.book.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.book.title,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'By ${widget.book.authorName?.join(", ") ?? "Unknown"}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Book Details Section
                _buildDetailCard(
                  context,
                  title: 'First Published Year',
                  value: widget.book.firstPublishYear.toString(),
                  icon: Icons.calendar_today,
                ),
                const SizedBox(height: 10),
                _buildDetailCard(
                  context,
                  title: 'Edition Count',
                  value: widget.book.editionCount.toString(),
                  icon: Icons.book,
                ),
                const SizedBox(height: 10),
                _buildDetailCard(
                  context,
                  title: 'Has Full Text',
                  value: widget.book.hasFulltext ? "Yes" : "No",
                  icon: Icons.text_snippet,
                ),

                // Button
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: state.wishlist.contains(Wishlist(
                            title: widget.book.title,
                            authorName: widget.book.authorName))
                        ? const Icon(Icons.favorite, color: Colors.red)
                        : const Icon(Icons.favorite_border,
                            color: Colors.white),
                    label: Text(
                      state.wishlist.contains(Wishlist(
                              title: widget.book.title,
                              authorName: widget.book.authorName))
                          ? 'Remove from Wishlist'
                          : 'Add to Wishlist',
                      style: const TextStyle(color: Color(0xFF0046A0)),
                    ),
                    onPressed: () {
                      if (state.wishlist.contains(Wishlist(
                          title: widget.book.title,
                          authorName: widget.book.authorName))) {
                        BlocProvider.of<BookBloc>(context).add(
                            RemoveFromWishlist(Wishlist(
                                title: widget.book.title,
                                authorName: widget.book.authorName)));
                        _showSnackBar(context, 'Book removed from wishlist!');
                      } else {
                        BlocProvider.of<BookBloc>(context).add(AddToWishlist(
                            Wishlist(
                                title: widget.book.title,
                                authorName: widget.book.authorName)));
                        _showSnackBar(context, 'Book added to wishlist!');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailCard(BuildContext context,
      {required String title, required String value, required IconData icon}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
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
