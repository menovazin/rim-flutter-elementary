import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/config/urls.dart';
import 'package:rim_elementary/utils/avatar_url_utils.dart';

void main() {
  test('avatarUrlFromId builds url from AppUrls.base', () {
    expect(
      AvatarUrlUtils.avatarUrlFromId(42),
      '${AppUrls.base}/character/avatar/42.jpeg',
    );
  });
}
