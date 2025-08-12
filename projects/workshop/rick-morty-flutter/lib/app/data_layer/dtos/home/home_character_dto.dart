import 'package:rick_morty/app/domain_layer/domain_layer.dart';

class HomeCharacterDTO extends HomeCharacterEntity {
  HomeCharacterDTO({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.type,
    required super.gender,
    required super.originName,
    required super.originUrl,
    required super.locationName,
    required super.locationUrl,
    required super.image,
    required super.episode,
    required super.url,
    required super.created,
  });

  factory HomeCharacterDTO.fromJson(Map<String, dynamic> json) {
    final origin = (json['origin'] as Map?) ?? const {};
    final location = (json['location'] as Map?) ?? const {};

    return HomeCharacterDTO(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      species: json['species'] ?? '',
      type: json['type'] ?? '',
      gender: json['gender'] ?? '',
      originName: origin['name'] ?? '',
      originUrl: origin['url'] ?? '',
      locationName: location['name'] ?? '',
      locationUrl: location['url'] ?? '',
      image: json['image'] ?? '',
      episode: (json['episode'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList(),
      url: json['url'] ?? '',
      created:
          json['created'] != null ? DateTime.tryParse(json['created']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': {'name': originName, 'url': originUrl},
      'location': {'name': locationName, 'url': locationUrl},
      'image': image,
      'episode': episode,
      'url': url,
      'created': created?.toIso8601String(),
    };
  }
}

extension HomeCharacterDTOExtension on HomeCharacterEntity {
  HomeCharacterDTO get toDTO => HomeCharacterDTO(
        id: id,
        name: name,
        status: status,
        species: species,
        type: type,
        gender: gender,
        originName: originName,
        originUrl: originUrl,
        locationName: locationName,
        locationUrl: locationUrl,
        image: image,
        episode: episode,
        url: url,
        created: created,
      );
}
