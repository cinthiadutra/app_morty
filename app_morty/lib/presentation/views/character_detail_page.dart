import 'package:app_morty/core/utils/app_colors.dart';
import 'package:app_morty/data/models/character_model.dart';
import 'package:flutter/material.dart';

// translate-me-ignore-all-file
class CharacterDetailPage extends StatelessWidget {
  final CharacterModel character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.secundary),
        backgroundColor: AppColors.primary,
        title: Text(
          character.name,
          style: TextStyle(
            fontFamily: 'get_schwifty',
            color: AppColors.secundary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(character.image),
            SizedBox(height: 30),

            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurpleAccent),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status: ${character.status}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.secundary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'Espécie: ${character.species}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.secundary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'Gênero: ${character.gender}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.secundary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'Localização: \n${character.location?.name}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.secundary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
