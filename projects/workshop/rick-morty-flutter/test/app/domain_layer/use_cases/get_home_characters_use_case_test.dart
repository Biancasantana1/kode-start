import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_morty/app/domain_layer/domain_layer.dart';
import 'package:rick_morty/app/infra/infra.dart';

import 'get_home_characters_use_case_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<IHomeRepository>(),
  MockSpec<HomeListEntity>(),
])
void main() {
  late MockIHomeRepository repo;
  late GetHomeCharactersUseCase usecase;
  late MockHomeListEntity homeListEntity;

  setUp(() {
    repo = MockIHomeRepository();
    usecase = GetHomeCharactersUseCase(repository: repo);
    homeListEntity = MockHomeListEntity();
  });

  group('GetHomeCharactersUseCase | Success ->', () {
    test('should delegate to repository and return HomeListEntity (no filters)',
        () async {
      when(repo.getCharacters(
              page: anyNamed('page'),
              name: anyNamed('name'),
              status: anyNamed('status')))
          .thenAnswer((_) async => homeListEntity);

      final result = await usecase(page: 1);

      expect(result, isA<HomeListEntity>());
      expect(identical(result, homeListEntity), isTrue);

      verify(repo.getCharacters(page: 1, name: null, status: null)).called(1);
      verifyNoMoreInteractions(repo);
    });

    test('should pass filters through and return HomeListEntity', () async {
      when(repo.getCharacters(
              page: anyNamed('page'),
              name: anyNamed('name'),
              status: anyNamed('status')))
          .thenAnswer((_) async => homeListEntity);

      final result = await usecase(page: 2, name: 'Rick', status: 'Alive');

      expect(result, isA<HomeListEntity>());
      expect(identical(result, homeListEntity), isTrue);

      verify(repo.getCharacters(page: 2, name: 'Rick', status: 'Alive'))
          .called(1);
      verifyNoMoreInteractions(repo);
    });
  });

  group('GetHomeCharactersUseCase | Error ->', () {
    test('should rethrow DataFailure from repository', () async {
      when(repo.getCharacters(
              page: anyNamed('page'),
              name: anyNamed('name'),
              status: anyNamed('status')))
          .thenThrow(DataFailure('Falha ao buscar personagens'));

      expect(
        () => usecase(page: 1),
        throwsA(
          isA<DataFailure>().having(
            (e) => e.message,
            'message',
            contains('Falha ao buscar personagens'),
          ),
        ),
      );

      verify(repo.getCharacters(page: 1, name: null, status: null)).called(1);
      verifyNoMoreInteractions(repo);
    });
  });
}
