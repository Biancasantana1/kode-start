import '../../../infra/infra.dart';
import '../../data_layer.dart';

class HomeDataSource {
  final IHttpClient http;

  HomeDataSource({required this.http});

  Future<HomeListDTO> getCharacters({
    required int page,
    String? name,
    String? status,
  }) async {
    final response = await http.get(
      Endpoints.homeCharacters,
      queryParameters: {
        'page': page,
        if ((name ?? '').trim().isNotEmpty) 'name': name!.trim(),
        if ((status ?? '').trim().isNotEmpty) 'status': status!.trim(),
      },
    );

    if (response.statusCode == 200) {
      return HomeListDTO.fromJson(response.data as Map<String, dynamic>);
    }
    throw DataFailure(response.data['error']);
  }

  Future<HomeCharacterDTO> getCharacterById({required int id}) async {
    final response = await http.get(Endpoints.homeCharactersDetail(id));

    if (response.statusCode == 200) {
      return HomeCharacterDTO.fromJson(response.data as Map<String, dynamic>);
    }

    throw DataFailure(response.data['error']);
  }
}
