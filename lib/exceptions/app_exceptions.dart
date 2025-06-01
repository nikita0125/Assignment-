class AppException implements Exception {
  final String message;
  AppException(this.message);
}

class NetworkException extends AppException {
  NetworkException() : super("No Internet Connection");
}

class TimeoutException extends AppException {
  TimeoutException() : super("Request Timeout");
}

class UnknownException extends AppException {
  UnknownException() : super("Unknown Error Occurred");
}
