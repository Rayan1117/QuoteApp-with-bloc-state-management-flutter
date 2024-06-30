import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {

  QuoteBloc() : super(QuoteInitial()) {
    on<FetchRandomQuoteEvent>((event, emit) async {
      await fetchQuote(emit);
    });
    
  }
  Future<void> fetchQuote(Emitter emit) async {
    try {
      emit(LoadingFetchRandomQuote());
      final response = await http.get(
        Uri.parse(
          "https://api.api-ninjas.com/v1/quotes",
        ),
        headers: {'X-Api-Key': 'ONExx+eAf+9KrhGOEOAtGw==yG5XwhrhoRQFUAez'},
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final content = body[0]['quote'];
        final author = body[0]['author'];
        emit(
          FetchRandomQuoteState(quote: content, author: author),
        );
      }
    } catch (error) {
      emit(
        FetchRandomQuoteState(quote: error.toString(), author: ""),
      );
    }
  }
}
