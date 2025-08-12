import 'package:rick_morty/app/domain_layer/domain_layer.dart';

abstract class IHomeRepository {
  Future<HomeListEntity> getCharacters({
    required int page,
    String? name,
    String? status,
  });

  Future<HomeCharacterEntity> getCharacterById({required int id});
}
