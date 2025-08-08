import 'package:app_morty/core/utils/app_colors.dart';
import 'package:app_morty/data/routes/app_routes.dart';
import 'package:app_morty/presentation/view_models/character_cubit.dart';
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

    Future.delayed(const Duration(seconds: 2), () {
      context.read<CharacterCubit>().fetchCharacters(isFirstLoad: true);
      Navigator.of(context).pushReplacementNamed(AppRoutes.characterList);
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
            SizedBox(height: 24),
            Image.asset('assets/images.logo.png'),
            SizedBox(height: 12),
            CircularProgressIndicator(color: AppColors.secundary),
          ],
        ),
      ),
    );
  }
}
