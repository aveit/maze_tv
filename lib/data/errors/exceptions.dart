import 'package:maze_tv/domain/errors/failures.dart';

abstract class AppException implements Exception {
  const AppException();
  Failure toFailure();
}

class ServerException extends AppException {
  const ServerException();
  @override
  Failure toFailure() {
    return const ServerFailure();
  }
}

class UnexpectedException extends AppException {
  const UnexpectedException();
  @override
  Failure toFailure() {
    return const UnexpectedFailure();
  }
}

class LocalException extends AppException {
  const LocalException();
  @override
  Failure toFailure() {
    return const LocalFailure();
  }
}
