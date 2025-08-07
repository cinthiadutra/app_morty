import 'package:app_morty/data/models/paginated_characters.dart';


abstract class CharacterRepository {
  Future<PaginatedCharacters> getCharacters({int page});
}
