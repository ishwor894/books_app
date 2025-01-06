import 'package:books_app/screens/books_list_screen.dart';
import 'package:books_app/services/http_service.dart';
import 'package:books_app/bloc/book_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final BookService bookService = BookService();

  MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookBloc(bookService: bookService), // Injecting the service.
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BooksListScreen(),
      ),
    );
  }
}
