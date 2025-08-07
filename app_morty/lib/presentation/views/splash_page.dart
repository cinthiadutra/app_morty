import 'package:app_morty/presentation/view_models/character_bloc.dart';
import 'package:app_morty/presentation/views/character_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Aguarda 2 segundos e navega
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const CharacterListPage(),
        ),
      );

      // Opcional: iniciar carregamento dos personagens
      context.read<CharacterCubit>().fetchCharacters(isFirstLoad: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://images.justwatch.com/poster/308654947/s718/temporada-1.jpg', // coloque a imagem no pubspec.yaml
              height: 120,
            ),
            const SizedBox(height: 24),
            const Text(
              'Rick & Morty',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
