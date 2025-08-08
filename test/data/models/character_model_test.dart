import 'package:app_morty/data/models/character_model.dart';
import 'package:app_morty/data/models/location.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CharacterModel', () {
    final map = {
      "id": 1,
      "name": "Rick Sanchez",
      "status": "Alive",
      "species": "Human",
      "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
      "gender": "Male",
      "location": {
        "name": "Earth (C-137)",
        "url": "https://rickandmortyapi.com/api/location/1"
      }
    };

    final character = CharacterModel(
      id: 1,
      name: "Rick Sanchez",
      status: "Alive",
      species: "Human",
      image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
      gender: "Male",
      location: Location(
        name: "Earth (C-137)",
        url: "https://rickandmortyapi.com/api/location/1",
      ),
    );

    test('fromMap should return valid CharacterModel', () {
      final result = CharacterModel.fromMap(map);
      expect(result.name, character.name);
      expect(result.location?.name, "Earth (C-137)");
    });

    test('toMap should return valid map', () {
      final result = character.toMap();
      expect(result['name'], "Rick Sanchez");
      expect(result['location'], isA<Map>());
      expect(result['location']?['name'], "Earth (C-137)");
    });

    test('fromJson and toJson should convert correctly', () {
      final json = character.toJson();
      final result = CharacterModel.fromJson(json);
      expect(result.name, character.name);
      expect(result.location?.url, character.location?.url);
    });

    test('toString returns expected string', () {
      final string = character.toString();
      expect(string, contains("Rick Sanchez"));
      expect(string, contains("Earth (C-137)"));
    });
  });
}
