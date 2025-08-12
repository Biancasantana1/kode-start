class HomeCharacterEntity {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String originName;
  final String originUrl;
  final String locationName;
  final String locationUrl;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime? created;

  HomeCharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.originName,
    required this.originUrl,
    required this.locationName,
    required this.locationUrl,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  const HomeCharacterEntity.empty()
      : id = 0,
        name = '',
        status = '',
        species = '',
        type = '',
        gender = '',
        originName = '',
        originUrl = '',
        locationName = '',
        locationUrl = '',
        image = '',
        episode = const [],
        url = '',
        created = null;
}
