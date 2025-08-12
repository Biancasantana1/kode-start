import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_morty/app/data_layer/data_layer.dart';
import 'package:rick_morty/app/infra/infra.dart';

import 'home_data_source_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<IHttpClient>(),
])
void main() {
  late HomeDataSource homeDataSource;
  late MockIHttpClient mockHttpClient;

  Response httpOk(dynamic data) => Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: data,
      );

  Response httpFail(int status, dynamic data) => Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: status,
        data: data,
      );

  final mapListOk = jsonDecode(r'''
  {
    "info": { "count": 826, "pages": 42, "next": null, "prev": null },
    "results": [
      { "id": 1, "name": "Rick Sanchez", "status": "Alive" }
    ]
  }
  ''');

  final mapCharOk = jsonDecode(r'''
  { "id": 2, "name": "Morty Smith", "status": "Alive" }
  ''');

  setUp(() {
    mockHttpClient = MockIHttpClient();
    homeDataSource = HomeDataSource(http: mockHttpClient);
  });

  group('HomeDataSource | Success ->', () {
    test('getCharacters() should return HomeListDTO', () async {
      when(mockHttpClient.get(
        Endpoints.homeCharacters,
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => httpOk(mapListOk));

      final result = await homeDataSource.getCharacters(page: 1);

      expect(result, isA<HomeListDTO>());
      verify(mockHttpClient.get(
        Endpoints.homeCharacters,
        queryParameters: anyNamed('queryParameters'),
      )).called(1);
    });

    test('getCharacters() should omit empty name and trim status', () async {
      Map<String, dynamic>? captured;

      when(mockHttpClient.get(
        Endpoints.homeCharacters,
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((invocation) async {
        captured = invocation.namedArguments[#queryParameters]
            as Map<String, dynamic>?;
        return httpOk(mapListOk);
      });

      await homeDataSource.getCharacters(
        page: 3,
        name: '   ',
        status: '  Alive  ',
      );

      expect(captured, isNotNull);
      expect(captured!['page'], 3);
      expect(captured!.containsKey('name'), isFalse);
      expect(captured!['status'], 'Alive');
    });

    test('getCharacterById() should return HomeCharacterDTO', () async {
      const id = 2;

      when(mockHttpClient.get(Endpoints.homeCharactersDetail(id)))
          .thenAnswer((_) async => httpOk(mapCharOk));

      final result = await homeDataSource.getCharacterById(id: id);

      expect(result, isA<HomeCharacterDTO>());
      verify(mockHttpClient.get(Endpoints.homeCharactersDetail(id))).called(1);
    });
  });

  group('HomeDataSource | Error ->', () {
    test('getCharacters() 200 but body is NOT a Map => throws TypeError', () {
      when(mockHttpClient.get(
        Endpoints.homeCharacters,
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => httpOk(['lista', 'invalida']));

      expect(
        homeDataSource.getCharacters(page: 1),
        throwsA(isA<TypeError>()),
      );
    });

    test('getCharacters() non-200 with body.error => DataFailure(error)', () {
      when(mockHttpClient.get(
        Endpoints.homeCharacters,
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => httpFail(404, {'error': 'Não encontrado'}));

      expect(
        homeDataSource.getCharacters(page: 99, name: 'X'),
        throwsA(isA<DataFailure>().having(
          (e) => e.message,
          'message',
          equals('Não encontrado'),
        )),
      );
    });

    test('getCharacters() 500 -> DataFailure(error)', () {
      when(mockHttpClient.get(
        Endpoints.homeCharacters,
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer(
          (_) async => httpFail(500, {'error': 'Falha ao buscar personagens'}));

      expect(
        homeDataSource.getCharacters(page: 1),
        throwsA(isA<DataFailure>().having(
          (e) => e.message,
          'message',
          equals('Falha ao buscar personagens'),
        )),
      );
    });

    test('getCharacterById() 200 but body is NOT a Map => throws TypeError',
        () {
      const id = 1;

      when(mockHttpClient.get(Endpoints.homeCharactersDetail(id)))
          .thenAnswer((_) async => httpOk('string invalida'));

      expect(
        homeDataSource.getCharacterById(id: id),
        throwsA(isA<TypeError>()),
      );
    });

    test('getCharacterById() 404 -> DataFailure(error)', () {
      const id = 9999;

      when(mockHttpClient.get(Endpoints.homeCharactersDetail(id))).thenAnswer(
        (_) async => httpFail(404, {'error': 'Personagem não encontrado'}),
      );

      expect(
        homeDataSource.getCharacterById(id: id),
        throwsA(isA<DataFailure>().having(
          (e) => e.message,
          'message',
          equals('Personagem não encontrado'),
        )),
      );
    });

    test('getCharacterById() 500 -> DataFailure(error)', () {
      const id = 5000;

      when(mockHttpClient.get(Endpoints.homeCharactersDetail(id))).thenAnswer(
          (_) async => httpFail(500, {'error': 'Falha ao buscar personagem'}));

      expect(
        homeDataSource.getCharacterById(id: id),
        throwsA(isA<DataFailure>().having(
          (e) => e.message,
          'message',
          equals('Falha ao buscar personagem'),
        )),
      );
    });
  });
}
