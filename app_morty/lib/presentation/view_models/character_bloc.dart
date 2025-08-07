import 'package:app_morty/data/models/character_model.dart';
import 'package:app_morty/domain/repository/character_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepository repository;

  CharacterCubit(this.repository) : super(CharacterInitial());

  List<CharacterModel> _allCharacters = [];
  int _currentPage = 1;
  bool _hasNextPage = true;

  Future<void> fetchCharacters({bool isFirstLoad = false}) async {
    if (state is CharacterLoading || !_hasNextPage) return;

    if (isFirstLoad) {
      emit(CharacterLoading());
      _allCharacters = [];
      _currentPage = 1;
      _hasNextPage = true;
    }

    try {
      final paginated = await repository.getCharacters(page: _currentPage);

      _allCharacters.addAll(paginated.characters);
      _hasNextPage = paginated.nextPage != null;

      emit(CharacterLoaded(
        characters: _allCharacters,
        hasNextPage: _hasNextPage,
        currentPage: _currentPage,
      ));

      _currentPage++;
    } catch (e) {
      emit(CharacterError('Erro ao carregar personagens'));
    }
  }
}
