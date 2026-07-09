List<int> extractIdsFromUrls(List<String> urls) {
  return urls
      .map((url) => int.tryParse(url.split('/').last) ?? 0)
      .where((id) => id > 0)
      .toList();
}
