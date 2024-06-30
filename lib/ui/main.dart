import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:learn/quotebloc/bloc/quote_bloc.dart";
import "package:learn/quotelistbloc/bloc/quote_list_bloc.dart";
import "package:learn/ui/quote_page.dart";

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<QuoteBloc>(
        create: (context) => QuoteBloc(),
      ),BlocProvider<QuoteListBloc>(
        create: (context) => QuoteListBloc(),
      ),
    ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuoteApp(),
    ),
  ));
}

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const QuotePage();
  }
}
