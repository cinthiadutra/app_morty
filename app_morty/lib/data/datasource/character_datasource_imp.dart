import 'package:app_morty/data/datasource/character_datasource.dart';
import 'package:app_morty/data/models/paginated_characters.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/dio_client.dart';

class CharacterDatasourceImpl extends CharacterDatasource {
  final DioClient dioClient;

  CharacterDatasourceImpl(this.dioClient);

  Future<PaginatedCharacters> getCharacters({int page = 1}) async {
    try {
      final response = await dioClient.dio.get('/character?page=$page');

      if (response.statusCode == 200 && response.data != null) {
        return PaginatedCharacters.fromJson(response.data);
      } else {
        throw Exception('Erro inesperado ao buscar personagens');
      }
    } on DioException catch (e) {
      // HTTP or network error
      throw Exception(
        'Erro de conexão: ${e.message} - código: ${e.response?.statusCode ?? 'sem código'}',
      );
    } catch (e) {
      // Any other error
      throw Exception('Erro desconhecido: ${e.toString()}');
    }
  }
}