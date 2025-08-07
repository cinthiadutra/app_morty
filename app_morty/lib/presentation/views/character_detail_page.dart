import 'package:app_morty/data/models/character_model.dart';
import 'package:flutter/material.dart';

class CharacterDetailPage extends StatelessWidget {
  final CharacterModel character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(character.image??""),
            const SizedBox(height: 16),
            Text('Status: ${character.status}', style: const TextStyle(fontSize: 18)),
            Text('Espécie: ${character.species}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
