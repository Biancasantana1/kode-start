import 'package:rick_morty/app/domain_layer/domain_layer.dart';

class GetHomeCharactersUseCase {
  final IHomeRepository _repository;

  GetHomeCharactersUseCase({required IHomeRepository repository})
      : _repository = repository;

  Future<HomeListEntity> call({
    required int page,
    String? name,
    String? status,
  }) {
    return _repository.getCharacters(page: page, name: name, status: status);
  }
}
