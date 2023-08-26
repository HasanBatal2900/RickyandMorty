part of 'quotes_cubit.dart';

@immutable
sealed class QuotesState {}

final class QuotesInitial extends QuotesState {}

class QuotesLoaded extends QuotesState {
 final List<Quotes> allQuotes ;
 

  QuotesLoaded({required this.allQuotes});


}
