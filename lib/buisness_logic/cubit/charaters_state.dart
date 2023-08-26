part of 'charaters_cubit.dart';

@immutable
sealed class CharactersState {}

final class CharatersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;
  CharactersLoaded({required this.characters});
}
