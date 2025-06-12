class NetworkFailure implements Exception {
  final String message;
  NetworkFailure([this.message = 'Network error']);
  @override String toString() => 'NetworkFailure: $message';
}
