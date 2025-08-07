import 'package:app_morty/data/models/paginated_characters.dart';

abstract class CharacterDatasource {
  Future<PaginatedCharacters> getCharacters({int page = 1});

}