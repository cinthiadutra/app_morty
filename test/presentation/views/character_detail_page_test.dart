import 'package:app_morty/data/models/character_model.dart';
import 'package:app_morty/data/models/location.dart';
import 'package:app_morty/presentation/views/character_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CharacterDetailPage displays character information correctly', (WidgetTester tester) async {
    // Arrange: create a fake character
    final fakeCharacter = CharacterModel(
      id: 1,
      name: 'Rick Sanchez',
      status: 'Alive',
      species: 'Human',
      gender: 'Male',
      image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
      location: Location(name: 'Citadel of Ricks', url: ''),
    );

    // Act: pump the widget
    await tester.pumpWidget(
      MaterialApp(
        home: CharacterDetailPage(character: fakeCharacter),
      ),
    );

    // Assert: verify presence of all key info
    expect(find.text('Rick Sanchez'), findsOneWidget);
    expect(find.text('Status: Alive'), findsOneWidget);
    expect(find.text('Espécie: Human'), findsOneWidget);
    expect(find.text('Gênero: Male'), findsOneWidget);
    expect(find.text('Localização: \nCitadel of Ricks'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
