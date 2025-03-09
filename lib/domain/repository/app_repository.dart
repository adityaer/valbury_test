import 'package:dartz/dartz.dart';
import 'package:valbury_test/data/model/response/album_detail_model.dart';
import 'package:valbury_test/data/model/response/comment_model.dart';
import 'package:valbury_test/data/model/response/profile_model.dart';
import 'package:valbury_test/domain/entity/album.dart';
import 'package:valbury_test/domain/entity/post.dart';
import 'package:valbury_test/util/failure.dart';

abstract class AppRepository {
  // Remote Data
  Future<Either<Failure, ProfileModel>> login(String email, String password);

  Future<Either<Failure, List<Post>>> getMyPostList(int userId);

  Future<Either<Failure, List<CommentModel>>> getMyCommentPostList(int postId);

  Future<Either<Failure, List<Album>>> getMyAlbumList(int userId);

  Future<Either<Failure, List<AlbumDetailModel>>> getMyAlbumDetailList(int albumId);
}
