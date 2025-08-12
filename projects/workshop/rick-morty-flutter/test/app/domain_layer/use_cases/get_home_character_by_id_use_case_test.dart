import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_morty/app/domain_layer/domain_layer.dart';
import 'package:rick_morty/app/infra/infra.dart';

import 'get_home_character_by_id_use_case_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<IHomeRepository>(),
  MockSpec<HomeCharacterEntity>(),
])
void main() {
  late MockIHomeRepository repo;
  late GetHomeCharacterByIdUseCase usecase;
  late MockHomeCharacterEntity homeCharacterEntity;

  setUp(() {
    repo = MockIHomeRepository();
    usecase = GetHomeCharacterByIdUseCase(repository: repo);
    homeCharacterEntity = MockHomeCharacterEntity();
  });

  group('GetHomeCharacterByIdUseCase | Success ->', () {
    test('should delegate to repository and return HomeCharacterEntity',
        () async {
      when(repo.getCharacterById(id: anyNamed('id')))
          .thenAnswer((_) async => homeCharacterEntity);

      final result = await usecase(id: 7);

      expect(result, isA<HomeCharacterEntity>());
      expect(identical(result, homeCharacterEntity), isTrue);

      verify(repo.getCharacterById(id: 7)).called(1);
      verifyNoMoreInteractions(repo);
    });
  });

  group('GetHomeCharacterByIdUseCase | Error ->', () {
    test('should rethrow DataFailure from repository', () async {
      when(repo.getCharacterById(id: anyNamed('id')))
          .thenThrow(DataFailure('Falha ao buscar personagem'));

      expect(
        () => usecase(id: 999),
        throwsA(
          isA<DataFailure>().having(
            (e) => e.message,
            'message',
            contains('Falha ao buscar personagem'),
          ),
        ),
      );

      verify(repo.getCharacterById(id: 999)).called(1);
      verifyNoMoreInteractions(repo);
    });
  });
}
