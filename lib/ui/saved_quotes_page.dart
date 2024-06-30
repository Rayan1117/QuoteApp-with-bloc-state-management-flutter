import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn/quotelistbloc/bloc/quote_list_bloc.dart';

class SavedQuotesPage extends StatefulWidget {
  const SavedQuotesPage({super.key});

  @override
  State<SavedQuotesPage> createState() => _SavedQuotesPageState();
}

class _SavedQuotesPageState extends State<SavedQuotesPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Quotes"),
      ),
      body: BlocConsumer<QuoteListBloc, QuoteListState>(
        listener: (context, state) {},
        builder: (context, state) {
          return (state is ShowSavedQuoteState)
              ? (state.quote.isNotEmpty)
                  ? ListView.builder(
                      itemCount: state.quote.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(30),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            contentPadding: const EdgeInsets.all(30),
                            tileColor: Colors.black26,
                            onLongPress: () => showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      actionsPadding: const EdgeInsets.all(10),
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      actions: [
                                        Column(
                                          children: [
                                            const Text(
                                                "Are You Sure to Delete?"),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("no"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    BlocProvider.of<
                                                                QuoteListBloc>(
                                                            context)
                                                        .add(
                                                      DeleteSavedQuoteEvent(
                                                          index: index),
                                                    );
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    "yes",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                            subtitle: Column(
                              children: [
                                Text(
                                  state.quote[index],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '''
                                  - ${state.author[index]}''',
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text("No Quotes Saved"),
                    )
              : const Center(
                  child: Text(
                    "something went wrong!!",
                    style: TextStyle(color: Colors.red),
                  ),
                );
        },
      ),
    );
  }
}
