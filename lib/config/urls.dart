/// Base API URL and environment flags.
class AppUrls {
  const AppUrls._();

  /// Active API domain (proxy with a Rick and Morty-compatible contract).
  static const String base = 'https://alpha.syazy.com/api';

  /// Whether to use mock data instead of the network.
  /// Set via `--dart-define=useMock=true`.
  static const bool useMock = bool.fromEnvironment('useMock');
}
