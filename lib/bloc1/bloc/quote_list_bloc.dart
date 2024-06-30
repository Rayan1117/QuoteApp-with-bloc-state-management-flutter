import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'quote_list_event.dart';
part 'quote_list_state.dart';

class QuoteListBloc extends Bloc<QuoteListEvent, QuoteListState> {
  final List<String> quote = [];
  final List<String> author = [];
  QuoteListBloc() : super(QuoteListInitial()) {
    on<SaveQuoteEvent>((event, emit) {
      quote.add(event.quote);
      author.add(event.author);
    });
    on<ShowSavedQuoteEvent>((event, emit) {
      emit(ShowSavedQuoteState(quote: quote, author: author));
    });
    on<DeleteSavedQuoteEvent>((event,emit){
      quote.removeAt(event.index);
      author.removeAt(event.index);
      emit(ShowSavedQuoteState(quote: quote, author: author));
    });
  }
}
