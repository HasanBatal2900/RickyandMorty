import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

String url = "https://type.fit/api/quotes";

class QuotesWebServices {
  Dio dio = Dio();

  // Future<List<Map<String, dynamic>>> getAllQutoes() async {
  //   var response = await dio.request("https://type.fit/api/quotes",
  //       options: Options(method: "GET"));

  //   log(response.data);

  //   print(response.data);
  //   if (response.statusCode == 200) {
  //     var mydata = json.decode(response.data);
  //     return mydata;
  //   } else {
  //     return [];
  //   }
  // }

  Future<List> getQuotes() async {
    var uri = Uri.parse(url);
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      return [];
    }
  }
}
