import 'package:app_morty/presentation/view_models/character_bloc.dart';
import 'package:app_morty/presentation/view_models/character_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'character_detail_page.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CharacterCubit>().fetchCharacters(isFirstLoad: true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        context.read<CharacterCubit>().fetchCharacters();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty')),
      body: BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
          if (state is CharacterLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CharacterError) {
            return Center(child: Text(state.message));
          }

          if (state is CharacterLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.characters.length + (state.hasNextPage ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= state.characters.length) {
                  return const Center(child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ));
                }

                final character = state.characters[index];
                return ListTile(
                  leading: Image.network(character.image??""),
                  title: Text(character.name),
                  subtitle: Text('${character.status} • ${character.species}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CharacterDetailPage(character: character),
                      ),
                    );
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
