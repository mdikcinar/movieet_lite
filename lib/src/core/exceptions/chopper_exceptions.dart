class JsonFactoryNotFoundException implements Exception {
  JsonFactoryNotFoundException([this.message = '']);
  final String message;
}
