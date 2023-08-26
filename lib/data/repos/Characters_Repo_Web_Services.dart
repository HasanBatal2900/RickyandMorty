import 'package:breaking_bad/data/models/characters.dart';
import 'package:breaking_bad/data/web_services/characters_web_services.dart';

class CharactersRepo {
  CharactersWebServices characterWebServices;
  CharactersRepo(this.characterWebServices);

  Future<List<Character>> getAllCharacters() async {
    final data = await characterWebServices.getAllCharacters();
    List<dynamic> characters = data["results"];
    return characters
        .map((character) => Character.fromJson(character))
        .toList(); //! List of All Characters
  }
}
