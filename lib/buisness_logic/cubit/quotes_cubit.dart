import 'package:bloc/bloc.dart';
import 'package:breaking_bad/data/models/quotes.dart';
import 'package:breaking_bad/data/repos/Quotes_Repo_Web_Services.dart';
import 'package:meta/meta.dart';

part 'quotes_state.dart';

class QuotesCubit extends Cubit<QuotesState> {
  QuotesCubit({required this.quotesRepo}) : super(QuotesInitial());

  QuotesRepo quotesRepo;

  List<Quotes> getAllQuotes() {
    quotesRepo.getAllQuotes().then((allQuotes) {
      emit(
        QuotesLoaded(allQuotes: allQuotes),
      );
      return allQuotes;
    });

    return [];
  }
}
