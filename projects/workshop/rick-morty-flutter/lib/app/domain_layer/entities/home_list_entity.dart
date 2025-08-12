import 'package:rick_morty/app/domain_layer/domain_layer.dart';

class HomeInfoEntity {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  const HomeInfoEntity({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  const HomeInfoEntity.empty()
      : count = 0,
        pages = 0,
        next = null,
        prev = null;
}

class HomeListEntity {
  final HomeInfoEntity info;
  final List<HomeCharacterEntity> results;

  const HomeListEntity({
    required this.info,
    required this.results,
  });

  const HomeListEntity.empty()
      : info = const HomeInfoEntity.empty(),
        results = const [];
}
