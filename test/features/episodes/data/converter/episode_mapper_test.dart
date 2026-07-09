import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/features/episodes/data/converter/episode_mapper.dart';
import 'package:rim_elementary/features/episodes/data/dto/episode_dto.dart';

void main() {
  group('mapEpisode', () {
    test('maps a complete EpisodeDto to Episode', () {
      const dto = EpisodeDto(
        id: 1,
        name: 'Pilot',
        airDate: 'December 2, 2013',
        episode: 'S01E01',
        characters: [
          'https://api/character/1',
          'https://api/character/2',
        ],
      );

      final episode = mapEpisode(dto);

      expect(episode.id, 1);
      expect(episode.name, 'Pilot');
      expect(episode.airDate, 'December 2, 2013');
      expect(episode.episodeCode, 'S01E01');
      expect(episode.characterIds, [1, 2]);
    });

    test('extracts character ids and drops invalid ones', () {
      const dto = EpisodeDto(
        id: 2,
        name: 'Test',
        airDate: 'January 1, 2020',
        episode: 'S01E02',
        characters: [
          'https://api/character/5',
          'not-a-url',
          'https://api/character/',
          'https://api/character/12',
        ],
      );

      final episode = mapEpisode(dto);

      expect(episode.characterIds, [5, 12]);
    });
  });

  group('mapEpisodeList', () {
    test('maps a list preserving order', () {
      const dtos = [
        EpisodeDto(
          id: 1,
          name: 'Pilot',
          airDate: 'December 2, 2013',
          episode: 'S01E01',
        ),
        EpisodeDto(
          id: 2,
          name: 'Lawnmower Dog',
          airDate: 'December 9, 2013',
          episode: 'S01E02',
        ),
      ];

      final episodes = mapEpisodeList(dtos);

      expect(episodes.length, 2);
      expect(episodes[0].id, 1);
      expect(episodes[1].id, 2);
    });
  });
}
