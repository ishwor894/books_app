import 'package:books_app/screens/login_screen.dart';
import 'package:books_app/services/hive_service.dart';
import 'package:books_app/services/http_service.dart';
import 'package:books_app/bloc/book_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  await HiveService().initHive();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final BookService bookService = BookService();
 

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BookBloc(bookService: bookService), // Injecting the service.
      child: MaterialApp(
        theme: ThemeData(primaryColor: const Color(0xFF0046A0),),
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
      ),
    );
  }
}
