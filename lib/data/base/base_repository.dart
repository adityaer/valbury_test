import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:valbury_test/util/exception.dart';
import 'package:valbury_test/util/failure.dart';

class BaseRepository {
  Future<Either<Failure, T>> execute<T>(Future<T> Function() function) async {
    try {
      final result = await function();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException catch (e) {
      return Left(ConnectionFailure(e.message));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(e.message));
    }
  }
}
