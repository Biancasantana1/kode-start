enum StatusFilter { all, alive, dead, unknown }

extension StatusFilterX on StatusFilter {
  String? toApi() {
    switch (this) {
      case StatusFilter.all:
        return null;
      case StatusFilter.alive:
        return 'alive';
      case StatusFilter.dead:
        return 'dead';
      case StatusFilter.unknown:
        return 'unknown';
    }
  }

  String get label {
    final n = toString().split('.').last;
    return n[0].toUpperCase() + n.substring(1);
  }
}

extension StatusFilterParsing on String {
  StatusFilter toStatusFilter() {
    final s = trim().toLowerCase();
    switch (s) {
      case '':
        return StatusFilter.all;
      case 'alive':
        return StatusFilter.alive;
      case 'dead':
        return StatusFilter.dead;
      case 'unknown':
        return StatusFilter.unknown;
      default:
        return StatusFilter.all;
    }
  }
}

extension NullableStatusFilterParsing on String? {
  StatusFilter toStatusFilter() => (this ?? '').toStatusFilter();
}

class StatusFilterCodec {
  static String? toApi(StatusFilter f) => f.toApi();
  static StatusFilter fromChip(String? v) => (v ?? '').toStatusFilter();
}
