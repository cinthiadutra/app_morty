import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/character_model.dart';
import '../../domain/repository/character_repository.dart';
import 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepository repository;

  final List<CharacterModel> _allCharacters = [];
  String _searchTerm = '';
  String _selectedSpecies = 'Todos';
  String _selectedGender = 'Todos';

  int _currentPage = 1;
  bool _hasNextPage = true;

  CharacterCubit(this.repository) : super(CharacterInitial());

  Future<void> fetchCharacters({bool isFirstLoad = false}) async {
    if (!_hasNextPage && !isFirstLoad) return;

    try {
      if (isFirstLoad) {
        emit(CharacterLoading());
        _currentPage = 1;
        _hasNextPage = true;
        _allCharacters.clear();
      }

      final result = await repository.getCharacters(page: _currentPage);
      _allCharacters.addAll(result.characters);
      _hasNextPage = result.nextPage != null;
      _applyFilters();
      _currentPage++;
    } catch (e) {
      emit(CharacterError(e.toString()));
    }
  }

  void updateSearch(String term) {
    _searchTerm = term.toLowerCase();
    _applyFilters();
  }

  void updateSpecies(String species) {
    _selectedSpecies = species;
    _applyFilters();
  }

  void updateGender(String gender) {
    _selectedGender = gender;
    _applyFilters();
  }

  void _applyFilters() {
    List<CharacterModel> filtered = _allCharacters;

    if (_searchTerm.isNotEmpty) {
      filtered = filtered
          .where((c) => c.name.toLowerCase().contains(_searchTerm))
          .toList();
    }

    if (_selectedSpecies != 'Todos') {
      filtered = filtered.where((c) => c.species == _selectedSpecies).toList();
    }

    if (_selectedGender != 'Todos') {
      filtered = filtered.where((c) => c.gender == _selectedGender).toList();
    }

    emit(
      CharacterLoaded(
        filtered,
        characters: filtered,
        hasNextPage: _hasNextPage,
        currentPage: _currentPage,
      ),
    );
  }

  List<String> get speciesList {
    final list = _allCharacters.map((e) => e.species).toSet().toList();
    list.sort();
    return ['Todos', ...list];
  }

  List<String> get genderList {
    final list = _allCharacters.map((e) => e.gender).toSet().toList();
    list.sort();
    return ['Todos', ...list];
  }
}
