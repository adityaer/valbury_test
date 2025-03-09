
import 'package:dartz/dartz.dart';
import 'package:valbury_test/data/model/response/post_model.dart';
import 'package:valbury_test/domain/entity/post.dart';
import 'package:valbury_test/domain/repository/app_repository.dart';
import 'package:valbury_test/util/failure.dart';

class GetMyPostList {
  final AppRepository _repository;

  GetMyPostList(this._repository);

  Future<Either<Failure, List<Post>>> execute(int userId) {
    return _repository.getMyPostList(userId);
  }
}
