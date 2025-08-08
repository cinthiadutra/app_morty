import 'package:app_morty/data/models/character_model.dart';
import 'package:app_morty/data/models/location.dart';
import 'package:app_morty/domain/repository/character_repository.dart';
import 'package:app_morty/presentation/view_models/character_cubit.dart';
import 'package:app_morty/presentation/view_models/character_state.dart';
import 'package:app_morty/presentation/views/character_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockCharacterCubit extends CharacterCubit {
  MockCharacterCubit() : super(FakeCharacterRepository() as CharacterRepository);

  void emitLoadedState() {
    emit(CharacterLoaded(
      [mockCharacter],
      characters: [mockCharacter],
      hasNextPage: false,
      currentPage: 1,
    ));
  }
}

class FakeCharacterRepository extends Fake {}

final mockCharacter = CharacterModel(
  id: 1,
  name: 'Rick Sanchez',
  status: 'Alive',
  species: 'Human',
  gender: 'Male',
  image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
  location: Location(name: 'Citadel of Ricks', url: ''),
);

void main() {
  testWidgets('CharacterListPage displays characters and filters',
      (WidgetTester tester) async {
    // Arrange
    final cubit = MockCharacterCubit();
    cubit.emitLoadedState();

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CharacterCubit>.value(
          value: cubit,
          child: const CharacterListPage(),
        ),
      ),
    );

    // Act & Assert
    expect(find.text('Rick e Morty'), findsOneWidget); // AppBar
    expect(find.byType(TextField), findsOneWidget); // Search
    expect(find.byType(DropdownButtonFormField<String>), findsNWidgets(2)); // Filters

    expect(find.text('Rick Sanchez'), findsOneWidget); // Character name
    expect(find.text('Alive • Human'), findsOneWidget); // Subtitle

    await tester.tap(find.byType(ListTile));
    await tester.pumpAndSettle();

    // Verifica se navegou para a CharacterDetailPage
    expect(find.text('Status: Alive'), findsOneWidget);
    expect(find.text('Espécie: Human'), findsOneWidget);
  });
}
