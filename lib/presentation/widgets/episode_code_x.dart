import '../../features/episodes/domain/model/episode.dart';

extension EpisodeCodeX on Episode {
  RegExpMatch? get _match =>
      RegExp(r'S(\d+)E(\d+)').firstMatch(episodeCode);

  int get seasonNumber {
    final m = _match;
    if (m == null) {
      return 0;
    }
    return int.tryParse(m.group(1) ?? '0') ?? 0;
  }

  int get episodeNumber {
    final m = _match;
    if (m == null) {
      return 0;
    }
    return int.tryParse(m.group(2) ?? '0') ?? 0;
  }

  String get seasonEpisodeLabel {
    final m = _match;
    if (m == null) {
      return episodeCode;
    }
    return 'S${m.group(1)}E${m.group(2)}';
  }
}
