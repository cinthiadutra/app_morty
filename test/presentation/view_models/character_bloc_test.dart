import 'package:app_morty/data/models/character_model.dart';
import 'package:app_morty/data/models/location.dart';
import 'package:app_morty/data/models/paginated_characters.dart';
import 'package:app_morty/data/repositories/character_repository.dart_impl.dart';
import 'package:app_morty/presentation/view_models/character_cubit.dart';
import 'package:app_morty/presentation/view_models/character_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockCharacterRepository extends Mock implements CharacterRepositoryImpl {}

void main() {
  late MockCharacterRepository repository;
  late CharacterCubit cubit;

  setUp(() {
    repository = MockCharacterRepository();
    cubit = CharacterCubit(repository);
  });

  final characters = [
    CharacterModel(
      id: 1,
      name: 'Rick',
      status: 'Alive',
      species: 'Human',
      image: 'url', gender: 'male', location: Location(
        name: ''
      ),
    ),
  ];

  blocTest<CharacterCubit, CharacterState>(
    'emits [CharacterLoading, CharacterLoaded] on fetch success',
    build: () {
      when(() => repository.getCharacters(page: 1))
          .thenAnswer((_) async => PaginatedCharacters(characters: characters, nextPage: null));
      return cubit;
    },
    act: (cubit) => cubit.fetchCharacters(isFirstLoad: true),
    expect: () => [
      isA<CharacterLoading>(),
      isA<CharacterLoaded>()
          .having((s) => s.characters.length, 'characters', 1)
          .having((s) => s.hasNextPage, 'hasNextPage', false),
    ],
  );

  blocTest<CharacterCubit, CharacterState>(
    'emits [CharacterLoading, CharacterError] on fetch error',
    build: () {
      when(() => repository.getCharacters(page: 1))
          .thenThrow(Exception('Erro'));
      return cubit;
    },
    act: (cubit) => cubit.fetchCharacters(isFirstLoad: true),
    expect: () => [
      isA<CharacterLoading>(),
      isA<CharacterError>(),
    ],
  );
}
