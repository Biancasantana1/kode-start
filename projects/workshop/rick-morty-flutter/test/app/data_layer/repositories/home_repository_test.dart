import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_morty/app/data_layer/data_layer.dart';
import 'package:rick_morty/app/domain_layer/domain_layer.dart';
import 'package:rick_morty/app/infra/infra.dart';

import 'home_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HomeDataSource>(),
  MockSpec<HomeListDTO>(),
  MockSpec<HomeCharacterDTO>(),
])
void main() {
  late HomeRepository repository;
  late MockHomeDataSource mockDataSource;

  late MockHomeListDTO homeListDTO;
  late MockHomeCharacterDTO homeCharacterDTO;

  setUp(() {
    mockDataSource = MockHomeDataSource();
    repository = HomeRepository(dataSource: mockDataSource);

    homeListDTO = MockHomeListDTO();
    homeCharacterDTO = MockHomeCharacterDTO();
  });

  group('HomeRepository | Success ->', () {
    test(
        'getCharacters() should delegate to dataSource and return HomeListEntity',
        () async {
      when(mockDataSource.getCharacters(
        page: anyNamed('page'),
        name: anyNamed('name'),
        status: anyNamed('status'),
      )).thenAnswer((_) async => homeListDTO);

      final result = await repository.getCharacters(page: 1);

      expect(result, isA<HomeListEntity>());
      expect(identical(result, homeListDTO), isTrue);

      verify(mockDataSource.getCharacters(page: 1, name: null, status: null))
          .called(1);
      verifyNoMoreInteractions(mockDataSource);
    });

    test('getCharacterById() should delegate and return HomeCharacterEntity',
        () async {
      when(mockDataSource.getCharacterById(id: anyNamed('id')))
          .thenAnswer((_) async => homeCharacterDTO);

      final result = await repository.getCharacterById(id: 7);

      expect(result, isA<HomeCharacterEntity>());
      expect(identical(result, homeCharacterDTO), isTrue);

      verify(mockDataSource.getCharacterById(id: 7)).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('HomeRepository | Error ->', () {
    test('getCharacters() should rethrow DataFailure from dataSource',
        () async {
      when(mockDataSource.getCharacters(
        page: anyNamed('page'),
        name: anyNamed('name'),
        status: anyNamed('status'),
      )).thenThrow(DataFailure('Falha ao buscar personagens'));

      expect(
        () => repository.getCharacters(page: 1),
        throwsA(
          isA<DataFailure>().having(
            (e) => e.message,
            'message',
            contains('Falha ao buscar personagens'),
          ),
        ),
      );

      verify(mockDataSource.getCharacters(page: 1, name: null, status: null))
          .called(1);
      verifyNoMoreInteractions(mockDataSource);
    });

    test('getCharacterById() should rethrow DataFailure from dataSource',
        () async {
      when(mockDataSource.getCharacterById(id: anyNamed('id')))
          .thenThrow(DataFailure('Falha ao buscar personagem'));

      expect(
        () => repository.getCharacterById(id: 999),
        throwsA(
          isA<DataFailure>().having(
            (e) => e.message,
            'message',
            contains('Falha ao buscar personagem'),
          ),
        ),
      );

      verify(mockDataSource.getCharacterById(id: 999)).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });
  });
}
