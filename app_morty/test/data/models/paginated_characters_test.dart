import 'package:app_morty/data/models/paginated_characters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('PaginatedCharacters fromJson parses correctly', () {
    final json = {
      "info": {
        "next": "https://rickandmortyapi.com/api/character?page=2"
      },
      "results": [
        {
          "id": 1,
          "name": "Rick Sanchez",
          "status": "Alive",
          "species": "Human",
          "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
        }
      ]
    };

    final paginated = PaginatedCharacters.fromJson(json);
    expect(paginated.characters.length, 1);
    expect(paginated.characters.first.name, "Rick Sanchez");
    expect(paginated.nextPage, contains("page=2"));
  });
}
