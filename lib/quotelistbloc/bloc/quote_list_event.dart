part of 'quote_list_bloc.dart';

@immutable
sealed class QuoteListEvent {}

class SaveQuoteEvent extends QuoteListEvent {
  final String quote;
  final String author;
  SaveQuoteEvent({required this.quote, required this.author});
}

class ShowSavedQuoteEvent extends QuoteListEvent {}

class DeleteSavedQuoteEvent extends QuoteListEvent {
  final int index;
  DeleteSavedQuoteEvent({required this.index});
}
