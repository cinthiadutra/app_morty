// lib/main.dart
import 'package:app_morty/data/routes/app_routes.dart';
import 'package:app_morty/presentation/view_models/character_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_morty/core/network/dio_client.dart';
import 'package:app_morty/data/datasource/character_datasource_imp.dart';
import 'package:app_morty/data/repositories/character_repository.dart_impl.dart';
import 'package:app_morty/domain/repository/character_repository.dart';

void main() {
  final dioClient = DioClient();
  final datasource = CharacterDatasourceImpl(dioClient);
  final repository = CharacterRepositoryImpl(datasource);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final CharacterRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterCubit>(
          create: (_) => CharacterCubit(repository),
        ),
      ],
      child: MaterialApp(
        title: 'Rick and Morty App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
      ),
    );
  }
}
