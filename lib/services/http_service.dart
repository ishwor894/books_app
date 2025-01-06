import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book_model.dart';

class BookService {
  Future<List<Doc>> fetchBooks() async {
    final response = await http.get(Uri.parse(
        'https://openlibrary.org/search.json?author=tolkien&sort=new'));

    if (response.statusCode == 200) {
      BookModel bookModel = BookModel.fromJson(json.decode(response.body));
      return bookModel.docs;
    } else {
      throw Exception('Failed to load books');
    }
  }
}
