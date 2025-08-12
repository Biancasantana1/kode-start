import 'package:rick_morty/app/domain_layer/domain_layer.dart';

class GetHomeCharacterByIdUseCase {
  final IHomeRepository _repository;

  GetHomeCharacterByIdUseCase({required IHomeRepository repository})
      : _repository = repository;

  Future<HomeCharacterEntity> call({required int id}) {
    return _repository.getCharacterById(id: id);
  }
}
