class ApplicationException implements Exception {
  final String code;
  final String text;

  const ApplicationException({required this.code, required this.text});

  @override
  String toString() => text;
}

class UnauthenticatedException implements Exception {
  const UnauthenticatedException();

  @override
  String toString() => "UnauthenticatedException";
}

class UnknownException implements Exception {
  final String? message;
  const UnknownException({this.message});

  @override
  String toString() => "UnknownException ${message ?? ""}";
}

class ConnectionErrorException implements Exception {
  const ConnectionErrorException();

  @override
  String toString() => "ConnectionErrorException";
}
