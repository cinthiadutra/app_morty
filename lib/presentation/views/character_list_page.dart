import 'package:app_morty/core/utils/app_colors.dart';
import 'package:app_morty/presentation/view_models/character_cubit.dart';
import 'package:app_morty/presentation/view_models/character_state.dart';
import 'package:app_morty/presentation/views/character_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// translate-me-ignore-all-file
class CharacterListPage extends StatelessWidget {
  const CharacterListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CharacterCubit>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Rick e Morty',
          style: TextStyle(
            fontSize: 28,
            fontFamily: 'get_schwifty',
            color: AppColors.secundary,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
          if (state is CharacterLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CharacterError) {
            print(state.message);
            return Center(child: Text('Erro: ${state.message}'));
          } else if (state is CharacterLoaded) {
            return Column(
              children: [
                _buildFilters(cubit),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.characters.length,
                    itemBuilder: (context, index) {
                      final character = state.characters[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.deepPurpleAccent,
                          ),
                          textColor: AppColors.secundary,
                          leading: Image.network(character.image),
                          title: Text(character.name),
                          subtitle: Text(
                            '${character.status} • ${character.species}',
                          ),
                          shape: Border.all(color: AppColors.secundary),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    CharacterDetailPage(character: character),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildFilters(CharacterCubit cubit) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          TextField(
            style: TextStyle(color: AppColors.secundary),
            decoration: const InputDecoration(
              labelText: 'Buscar por nome',
              labelStyle: TextStyle(color: Colors.deepPurpleAccent),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.secundary),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.secundary),
              ),
              prefixIcon: Icon(Icons.search, color: Colors.deepPurpleAccent),
            ),
            onChanged: cubit.updateSearch,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  style: TextStyle(color: AppColors.secundary),
                  value: 'Todos',
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secundary),
                    ),
                    fillColor: Colors.deepPurpleAccent,
                    labelText: 'Espécie',
                    labelStyle: TextStyle(color: AppColors.secundary),
                  ),
                  items: cubit.speciesList
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) cubit.updateSpecies(value);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  style: TextStyle(color: Colors.deepPurpleAccent),

                  value: 'Todos',

                  decoration: const InputDecoration(
                    labelText: 'Gênero',
                    fillColor: Colors.deepPurpleAccent,
                    labelStyle: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                  items: cubit.genderList
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) cubit.updateGender(value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
