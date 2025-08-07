import 'package:app_morty/data/models/character_model.dart';


abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<CharacterModel> characters;
  final bool hasNextPage;
  final int currentPage;

  CharacterLoaded({
    required this.characters,
    required this.hasNextPage,
    required this.currentPage,
  });
}

class CharacterError extends CharacterState {
  final String message;

  CharacterError(this.message);
}
