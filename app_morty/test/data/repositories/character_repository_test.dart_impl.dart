import 'package:app_morty/data/datasource/character_datasource.dart';
import 'package:app_morty/data/models/character_model.dart';
import 'package:app_morty/data/models/location.dart';
import 'package:app_morty/data/models/paginated_characters.dart';
import 'package:app_morty/data/repositories/character_repository.dart_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock da datasource
// translate-me-ignore-all-file
class MockCharacterDatasource extends Mock implements CharacterDatasource {}

void main() {
  late CharacterRepositoryImpl repository;
  late MockCharacterDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockCharacterDatasource();
    repository = CharacterRepositoryImpl(mockDatasource);
  });

  final mockResponse = PaginatedCharacters(
    characters: [
      CharacterModel(
        id: 1,
        name: 'Rick Sanchez',
        status: 'Alive',
        species: 'Human',
        gender: 'Male',
        // translate-me-ignore-next-line
        image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
        location: Location(name: 'Earth', url: ''),
      ),
    ],
    nextPage: 'https://rickandmortyapi.com/api/character?page=2',
  );

  test('should return PaginatedCharacters from datasource', () async {
    // Arrange
    when(() => mockDatasource.getCharacters(page: 1))
        .thenAnswer((_) async => mockResponse);

    // Act
    final result = await repository.getCharacters(page: 1);

    // Assert
    expect(result.characters.first.name, 'Rick Sanchez');
    expect(result.nextPage, isNotNull);
    verify(() => mockDatasource.getCharacters(page: 1)).called(1);
  });
}
