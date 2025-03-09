import 'package:valbury_test/data/base/base_remote_data_source.dart';
import 'package:valbury_test/data/model/request/login_request.dart';
import 'package:valbury_test/data/model/response/album_detail_model.dart';
import 'package:valbury_test/data/model/response/album_model.dart';
import 'package:valbury_test/data/model/response/comment_model.dart';
import 'package:valbury_test/data/model/response/post_model.dart';
import 'package:valbury_test/data/model/response/profile_model.dart';

abstract class AppRemoteDataSource {
  Future<ProfileModel> login(LoginRequest request);

  Future<List<PostModel>> getMyPostList(int userId);

  Future<List<CommentModel>> getMyCommentPostList(int postId);

  Future<List<AlbumModel>> getMyAlbumList(int userId);

  Future<List<AlbumDetailModel>> getMyAlbumDetailList(int albumId);
}

class AppRemoteDataSourceImpl extends BaseRemoteDataSource
    implements AppRemoteDataSource {
  AppRemoteDataSourceImpl({required super.client});

  @override
  Future<ProfileModel> login(LoginRequest request) async {
    var profile = ProfileModel();

    if (request.email == 'johndoe@test.com' &&
        request.password == 'wednesday') {
      profile.email = 'johndoe@test.com';
      profile.imagePath =
          'https://thepracticaldev.s3.amazonaws.com/uploads/user/profile_image/50592/f46e43c2-f4f0-4787-b34e-a310cecc221a.jpg';
      profile.userId = 1;
    }

    if (request.email == 'janedoe@test.com' && request.password == 'friday') {
      profile.email = 'janedoe@test.com';
      profile.imagePath =
          'https://avatars0.githubusercontent.com/u/1500684?s=460&v=4';
      profile.userId = 2;
    }

    return profile;
  }

  @override
  Future<List<PostModel>> getMyPostList(int userId) async {
    return await handleResponse<List<PostModel>>(
      client.get('$BASE_URL/posts?user_id=$userId'),
      (data) =>
          List<PostModel>.from(data.map((model) => PostModel.fromJson(model))),
    );
  }

  @override
  Future<List<CommentModel>> getMyCommentPostList(int postId) async {
    return await handleResponse<List<CommentModel>>(
      client.get('$BASE_URL/comments?postId=$postId'),
      (data) => List<CommentModel>.from(
        data.map((model) => CommentModel.fromJson(model)),
      ),
    );
  }

  @override
  Future<List<AlbumModel>> getMyAlbumList(int userId) async {
    return await handleResponse<List<AlbumModel>>(
      client.get('$BASE_URL/albums?user_id=$userId'),
      (data) => List<AlbumModel>.from(
        data.map((model) => AlbumModel.fromJson(model)),
      ),
    );
  }

  @override
  Future<List<AlbumDetailModel>> getMyAlbumDetailList(int albumId) async {
    return await handleResponse<List<AlbumDetailModel>>(
      client.get('$BASE_URL/albums_detail?album_id=$albumId'),
      (data) => List<AlbumDetailModel>.from(
        data.map((model) => AlbumDetailModel.fromJson(model)),
      ),
    );
  }
}
