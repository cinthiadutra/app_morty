import 'package:app_morty/core/network/dio_client.dart';
import 'package:app_morty/data/datasource/character_datasource.dart';
import 'package:app_morty/data/datasource/character_datasource_imp.dart';
import 'package:app_morty/data/models/paginated_characters.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late DioMock dioMock;
  late DioClient dioClient;
  late CharacterDatasource datasource;

  setUp(() {
    dioMock = DioMock();
    dioClient = DioClient()..dio.httpClientAdapter = dioMock.httpClientAdapter;
    dioClient.dio = dioMock;
    datasource = CharacterDatasourceImpl(dioClient);
  });

  test('should return PaginatedCharacters on success', () async {
    final jsonResponse = {
      "info": {"next": "url"},
      "results": [
        {
          "id": 1,
          "name": "Rick",
          "status": "Alive",
          "species": "Human",
          "image": "url"
        }
      ]
    };

    when(() => dioMock.get(any())).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: jsonResponse,
        ));

    final result = await datasource.getCharacters(page: 1);

    expect(result, isA<PaginatedCharacters>());
    expect(result.characters.first.name, "Rick");
  });

  test('should throw Exception on error', () async {
    when(() => dioMock.get(any())).thenThrow(DioException(
      requestOptions: RequestOptions(path: ''),
      type: DioExceptionType.badResponse,
      response: Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 500,
      ),
    ));

    expect(() => datasource.getCharacters(page: 1), throwsA(isA<Exception>()));
  });
}
