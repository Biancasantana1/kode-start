enum CharacterStatus { alive, dead, unknown }

extension CharacterStatusApi on CharacterStatus {
  String get api {
    switch (this) {
      case CharacterStatus.alive:
        return 'alive';
      case CharacterStatus.dead:
        return 'dead';
      case CharacterStatus.unknown:
        return 'unknown';
    }
  }

  static CharacterStatus fromApi(String? s) {
    switch ((s ?? '').toLowerCase()) {
      case 'alive':
        return CharacterStatus.alive;
      case 'dead':
        return CharacterStatus.dead;
      default:
        return CharacterStatus.unknown;
    }
  }

  String get label {
    final a = api;
    return a[0].toUpperCase() + a.substring(1);
  }
}
