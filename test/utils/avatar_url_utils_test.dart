import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/config/urls.dart';
import 'package:rim_elementary/utils/avatar_url_utils.dart';

void main() {
  group('AvatarUrlUtils', () {
    test('getCustomAvatarUrl prepends base for relative paths', () {
      const relative = '/character/avatar/1.jpeg';

      expect(
        AvatarUrlUtils.getCustomAvatarUrl(relative),
        '${AppUrls.base}$relative',
      );
    });

    test('getCustomAvatarUrl returns absolute URL unchanged', () {
      const url = 'https://rickandmortyapi.com/api/character/avatar/1.jpeg';

      expect(AvatarUrlUtils.getCustomAvatarUrl(url), url);
    });

    test('getCustomAvatarUrl returns empty string unchanged', () {
      expect(AvatarUrlUtils.getCustomAvatarUrl(''), '');
    });

    test('avatarUrlFromId builds url from AppUrls.base', () {
      expect(
        AvatarUrlUtils.avatarUrlFromId(42),
        '${AppUrls.base}/character/avatar/42.jpeg',
      );
    });
  });
}