import 'package:dartz/dartz.dart';
import 'package:valbury_test/data/model/response/profile_model.dart';
import 'package:valbury_test/domain/repository/app_repository.dart';
import 'package:valbury_test/util/failure.dart';

class GetLogin {
  final AppRepository _repository;

  GetLogin(this._repository);

  Future<Either<Failure, ProfileModel>> execute(String email, String password) {
    return _repository.login(email, password);
  }
}
