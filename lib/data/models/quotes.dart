class Quotes {
  late String text;
  late String author;

  Quotes({required this.author, required this.text});

  Quotes.fromJson(Map<String, dynamic> json) {
    text = json["name"];
    author = json["status"];
  }
}
