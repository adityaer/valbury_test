import 'package:dartz/dartz.dart';
import 'package:valbury_test/data/model/response/comment_model.dart';
import 'package:valbury_test/domain/repository/app_repository.dart';
import 'package:valbury_test/util/failure.dart';

class GetMyCommentPostList {
  final AppRepository _repository;

  GetMyCommentPostList(this._repository);

  Future<Either<Failure, List<CommentModel>>> execute(int postId) {
    return _repository.getMyCommentPostList(postId);
  }
}
