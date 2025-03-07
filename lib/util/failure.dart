import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int code;

  const Failure(this.message, this.code);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message, 1);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message, 2);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message, 3);
}

class ParsingFailure extends Failure {
  const ParsingFailure(String message) : super(message, 4);
}
