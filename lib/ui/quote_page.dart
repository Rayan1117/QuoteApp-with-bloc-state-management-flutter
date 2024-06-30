import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learn/quotebloc/bloc/quote_bloc.dart';
import 'package:learn/quotelistbloc/bloc/quote_list_bloc.dart';
import 'package:learn/ui/saved_quotes_page.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({super.key});

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<QuoteBloc>(context).add(
      FetchRandomQuoteEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuoteBloc, QuoteState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(40),
                ),
                onTap: () {
                  BlocProvider.of<QuoteListBloc>(context)
                      .add(ShowSavedQuoteEvent());
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SavedQuotesPage(),
                    ),
                  );
                },
                child: const Icon(Icons.task),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
            title: const Text("Quote of the Day"),
          ),
          body: Center(
            child: Container(
              padding: const EdgeInsets.all(60),
              child: ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                tileColor: Colors.black12,
                contentPadding: const EdgeInsets.all(60),
                subtitle: (state is LoadingFetchRandomQuote)
                    ? const Padding(
                        padding: EdgeInsets.all(190),
                        child: CircularProgressIndicator(),
                      )
                    : (state is FetchRandomQuoteState)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.quote.toString(),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("- ${state.author}"),
                                ],
                              )
                            ],
                          )
                        : null,
              ),
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  (state is FetchRandomQuoteState)
                      ? BlocProvider.of<QuoteListBloc>(context).add(
                          SaveQuoteEvent(
                              author: state.author, quote: state.quote),
                        )
                      : ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text(
                              "quote not fetched yet!!!",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                },
                child: const Icon(Icons.save),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  (state is FetchRandomQuoteState)
                      ? Share.share('''${state.quote}
                  
                  '''
                          "- ${state.author}")
                      : ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text(
                              "quote not fetched yet!!!",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                },
                child: const Icon(Icons.share),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  (state is !LoadingFetchRandomQuote)?
                  BlocProvider.of<QuoteBloc>(context).add(
                    FetchRandomQuoteEvent(),
                  ):ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text(
                              "quote not fetched yet!!!",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                },
                child: const Icon(Icons.refresh),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  (state is FetchRandomQuoteState)
                      ? {
                          Clipboard.setData(
                            ClipboardData(text: state.quote),
                          ),
                          Fluttertoast.showToast(msg: "copied ")
                        }
                      : ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text(
                              "quote not fetched yet!!!",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                },
                child: const Icon(Icons.copy),
              ),
            ],
          ),
        );
      },
    );
  }
}
