import 'package:app_morty/data/datasource/character_datasource.dart';
import 'package:app_morty/data/datasource/character_datasource_imp.dart';
import 'package:app_morty/data/repositories/character_repository.dart_impl.dart';
import 'package:app_morty/domain/repository/character_repository.dart';
import 'package:app_morty/presentation/view_models/character_bloc.dart';
import 'package:app_morty/presentation/views/character_list_page.dart';
import 'package:app_morty/presentation/views/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/network/dio_client.dart';

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
    return MaterialApp(
      title: 'Rick and Morty App',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => CharacterCubit(repository),
        child: SplashPage(),
      ),
    );
  }
}
