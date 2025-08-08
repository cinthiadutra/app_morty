import 'package:app_morty/data/datasource/character_datasource.dart';
import 'package:app_morty/data/models/paginated_characters.dart';

import '../../domain/repository/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterDatasource datasource;

  CharacterRepositoryImpl(this.datasource);

  @override
  Future<PaginatedCharacters> getCharacters({int page = 1}) {
    return datasource.getCharacters(page: page);
  }
}
