import 'character_model.dart';

class PaginatedCharacters {
  final List<CharacterModel> characters;
  final String? nextPage;

  PaginatedCharacters({required this.characters, required this.nextPage});

  factory PaginatedCharacters.fromJson(Map<String, dynamic> json) {
    final results = json['results'] as List;
    final characters = results.map((e) => CharacterModel.fromMap(e)).toList();

    return PaginatedCharacters(
      characters: characters,
      nextPage: json['info']['next'] as String?,
    );
  }
}
