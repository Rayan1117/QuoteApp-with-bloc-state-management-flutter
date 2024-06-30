part of 'quote_bloc.dart';

@immutable
sealed class QuoteEvent {}

class FetchRandomQuoteEvent extends QuoteEvent{

}
