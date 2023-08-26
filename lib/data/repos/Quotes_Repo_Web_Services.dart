import 'package:breaking_bad/data/models/quotes.dart';
import 'package:breaking_bad/data/web_services/Quotes_Web_Services.dart';

class QuotesRepo {
  QuotesWebServices quotesWebServices;
  QuotesRepo({required this.quotesWebServices});
  Future<List<Quotes>> getAllQuotes() async {
    final data = await quotesWebServices.getQuotes();
    return data
        .map((quote) => Quotes(author: quote["author"], text: quote["text"]))
        .toList();
  }
}
