import '../config/urls.dart';

class AvatarUrlUtils {
  const AvatarUrlUtils._();

  static String getCustomAvatarUrl(String originalUrl) {
    if (originalUrl.startsWith('/')) {
      return '${AppUrls.base}$originalUrl';
    }

    return originalUrl;
  }

  static String avatarUrlFromId(int id) =>
      '${AppUrls.base}/character/avatar/$id.jpeg';
}