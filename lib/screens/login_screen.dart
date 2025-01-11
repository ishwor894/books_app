import 'package:books_app/bloc/book_bloc.dart';
import 'package:books_app/bloc/book_event.dart';
import 'package:books_app/bloc/book_state.dart';
import 'package:books_app/screens/books_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 40, top: 20),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                        color: Color(0xFF0046A0)),
                  ),
                ),
                const Text(
                  "Email",
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25, top: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey)),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                const Text(
                  "Password",
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25, top: 8),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey)),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              border: InputBorder.none),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.visibility_outlined)),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 14.0,
                          width: 14.0,
                          child: Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              value: false,
                              onChanged: (value) {}),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "Remember me",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Color(0xFF192FA4)),
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 24),
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        minWidth: MediaQuery.of(context).size.width,
                        color: const Color(0xFF0046A0),
                        onPressed: () {
                          BlocProvider.of<BookBloc>(context)
                              .add(FetchWishlist());
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const BooksListScreen(),
                            ),
                          );
                        },
                        child: const Padding(
                            padding: EdgeInsets.only(top: 16, bottom: 16),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ))))
              ],
            ),
          );
        },
      ),
    );
  }
}
