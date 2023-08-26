import 'package:dio/dio.dart';

String baseUrl = "https://rickandmortyapi.com/api/";

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: 30 * 1000),
      receiveTimeout: const Duration(milliseconds: 30 * 1000),
      receiveDataWhenStatusError: true,
    );

    dio = Dio(options);
  }
  Future<Map<String, dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get("character");
      var data = response.data;
      print(data.toString());
      return data;
    } catch (e) {
      print(e.toString());
      return {};
    }
  }
}
