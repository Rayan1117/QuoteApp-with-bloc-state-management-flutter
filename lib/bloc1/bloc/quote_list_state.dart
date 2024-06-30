part of 'quote_list_bloc.dart';

@immutable
sealed class QuoteListState {}

final class QuoteListInitial extends QuoteListState {}

final class SaveQuoteState extends QuoteListState {}

final class ShowSavedQuoteState extends QuoteListState {
  final List<String> quote;
  final List<String> author;

  ShowSavedQuoteState({required this.quote, required this.author});
}