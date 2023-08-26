import 'package:bloc/bloc.dart';
import 'package:breaking_bad/data/models/characters.dart';
import 'package:breaking_bad/data/repos/Characters_Repo_Web_Services.dart';
import 'package:meta/meta.dart';

part 'charaters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit({required this.charactersRepo}) : super(CharatersInitial());
  CharactersRepo charactersRepo;
  List<Character> myCharacters = [];

  List<Character> getAllYourcharacters() {
    charactersRepo.getAllCharacters().then((characters) {
      myCharacters = characters;
      emit(CharactersLoaded(characters: characters));
    });
    return myCharacters;
  }
}
