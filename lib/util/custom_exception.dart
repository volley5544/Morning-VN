class RESTApiException implements Exception {
  String cause;
  RESTApiException(this.cause);
}
