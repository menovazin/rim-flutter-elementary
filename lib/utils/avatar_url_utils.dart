import '../config/urls.dart';

class AvatarUrlUtils {
  const AvatarUrlUtils._();

  static String avatarUrlFromId(int id) =>
      '${AppUrls.base}/character/avatar/$id.jpeg';
}
