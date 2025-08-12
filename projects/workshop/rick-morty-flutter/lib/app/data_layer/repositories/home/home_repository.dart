import 'package:rick_morty/app/data_layer/data_layer.dart';

import '../../../domain_layer/domain_layer.dart';

class HomeRepository implements IHomeRepository {
  final HomeDataSource dataSource;

  HomeRepository({required this.dataSource});

  @override
  Future<HomeListEntity> getCharacters({
    required int page,
    String? name,
    String? status,
  }) {
    return dataSource.getCharacters(page: page, name: name, status: status);
  }

  @override
  Future<HomeCharacterEntity> getCharacterById({required int id}) {
    return dataSource.getCharacterById(id: id);
  }
}
