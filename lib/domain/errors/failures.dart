abstract class Failure {
  const Failure();
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure();
}

class ServerFailure extends Failure {
  const ServerFailure();
}
