import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:learn/loginbloc/login_bloc.dart";
import "package:learn/ui/registration_page.dart";

void main() {
  runApp(
    BlocProvider(
      create: (context) => LoginBloc(),
      child: const MaterialApp(home: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthencationPage();
  }
}