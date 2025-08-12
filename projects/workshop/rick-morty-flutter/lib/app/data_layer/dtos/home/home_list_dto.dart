import 'package:rick_morty/app/data_layer/data_layer.dart';
import 'package:rick_morty/app/domain_layer/domain_layer.dart';

class HomeListDTO extends HomeListEntity {
  HomeListDTO({
    required super.info,
    required super.results,
  });

  factory HomeListDTO.fromJson(Map<String, dynamic> json) {
    final info = json['info'] as Map<String, dynamic>? ?? {};
    final results = (json['results'] as List<dynamic>? ?? const [])
        .map((e) => HomeCharacterDTO.fromJson(e as Map<String, dynamic>))
        .toList();

    return HomeListDTO(
      info: HomeInfoEntity(
        count: info['count'] ?? 0,
        pages: info['pages'] ?? 0,
        next: info['next'],
        prev: info['prev'],
      ),
      results: results,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'info': {
        'count': info.count,
        'pages': info.pages,
        'next': info.next,
        'prev': info.prev,
      },
      'results': results.map((e) => (e as HomeCharacterDTO).toJson()).toList(),
    };
  }
}
