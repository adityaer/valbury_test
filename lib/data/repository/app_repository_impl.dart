import 'package:dartz/dartz.dart';
import 'package:valbury_test/data/base/base_repository.dart';
import 'package:valbury_test/data/datasource/app_remote_data_source.dart';
import 'package:valbury_test/data/model/request/login_request.dart';
import 'package:valbury_test/data/model/response/album_detail_model.dart';
import 'package:valbury_test/data/model/response/comment_model.dart';
import 'package:valbury_test/data/model/response/profile_model.dart';
import 'package:valbury_test/domain/entity/album.dart';
import 'package:valbury_test/domain/entity/post.dart';
import 'package:valbury_test/domain/repository/app_repository.dart';
import 'package:valbury_test/util/failure.dart';

class AppRepositoryImpl extends BaseRepository implements AppRepository {
  final AppRemoteDataSource remoteDataSource;

  //final AppLocalDataSource localDataSource;

  AppRepositoryImpl({
    required this.remoteDataSource,
    //required this.localDataSource,
  });

  //Remote
  @override
  Future<Either<Failure, ProfileModel>> login(
    String email,
    String password,
  ) async {
    return execute(() async {
      final result = await remoteDataSource.login(
        LoginRequest(email: email, password: password),
      );

      return result;
    });
  }

  @override
  Future<Either<Failure, List<Post>>> getMyPostList(int userId) async {
    return execute(() async {
      final result = await remoteDataSource.getMyPostList(userId);

      return result.map((data) => data.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, List<CommentModel>>> getMyCommentPostList(
    int postId,
  ) async {
    return execute(() async {
      final result = await remoteDataSource.getMyCommentPostList(postId);

      return result;
    });
  }

  @override
  Future<Either<Failure, List<Album>>> getMyAlbumList(int userId) async {
    return execute(() async {
      final result = await remoteDataSource.getMyAlbumList(userId);

      return result.map((data) => data.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, List<AlbumDetailModel>>> getMyAlbumDetailList(
    int albumId,
  ) async {
    return execute(() async {
      final result = await remoteDataSource.getMyAlbumDetailList(albumId);

      return result;
    });
  }
}
