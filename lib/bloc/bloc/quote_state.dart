part of 'quote_bloc.dart';

@immutable
sealed class QuoteState {}

final class QuoteInitial extends QuoteState {}

final class FetchRandomQuoteState extends QuoteState{
  final String quote;
  final String author;
  FetchRandomQuoteState({required this.quote,required this.author});
}

final class LoadingFetchRandomQuote extends QuoteState{
  
}
