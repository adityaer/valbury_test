import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:valbury_test/data/datasource/app_remote_data_source.dart';
import 'package:valbury_test/data/model/response/album_detail_model.dart';
import 'package:valbury_test/data/model/response/album_model.dart';
import 'package:valbury_test/data/model/response/comment_model.dart';
import 'package:valbury_test/data/model/response/post_model.dart';

import '../../json_reader.dart';

void main() {
  const BASE_URL = 'https://my-json-server.typicode.com/adityaer/demo';

  late AppRemoteDataSourceImpl dataSource;
  late Dio dio;
  late DioAdapter dioAdapter;

  var userId = 1;
  var postId = 1;
  var albumId = 1;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: BASE_URL));
    dioAdapter = DioAdapter(dio: dio);
    dataSource = AppRemoteDataSourceImpl(client: dioAdapter.dio);
  });

  group('get Post List Response', () {
    final tPostList = List<PostModel>.from(
      json
          .decode(readJson('dummy/post_list.json'))
          .map((model) => PostModel.fromJson(model)),
    );

    test(
      'should return Post List Response when the response code is 200',
      () async {
        // arrange
        dioAdapter.onGet(
          '$BASE_URL/posts?user_id=$userId',
          (request) => request.reply(200, readJson('dummy/post_list.json')),
        );
        // act
        final result = await dataSource.getMyPostList(userId);
        // assert
        expect(result.length, equals(tPostList.length));
        expect(result[0].id, equals(tPostList[0].id));
        expect(result[0].title, equals(tPostList[0].title));
      },
    );
  });

  group('get Comment List Response', () {
    final tCommentList = List<CommentModel>.from(
      json
          .decode(readJson('dummy/comment_list.json'))
          .map((model) => CommentModel.fromJson(model)),
    );

    test(
      'should return Comment List Response when the response code is 200',
      () async {
        // arrange
        dioAdapter.onGet(
          '$BASE_URL/comments?postId=$postId',
          (request) => request.reply(200, readJson('dummy/comment_list.json')),
        );
        // act
        final result = await dataSource.getMyCommentPostList(postId);
        // assert
        expect(result.length, equals(tCommentList.length));
        expect(result[0].id, equals(tCommentList[0].id));
        expect(result[0].body, equals(tCommentList[0].body));
      },
    );
  });

  group('get Album List Response', () {
    final tAlbumList = List<AlbumModel>.from(
      json
          .decode(readJson('dummy/album_list.json'))
          .map((model) => AlbumModel.fromJson(model)),
    );

    test(
      'should return Album List Response when the response code is 200',
      () async {
        // arrange
        dioAdapter.onGet(
          '$BASE_URL/albums?user_id=$userId',
          (request) => request.reply(200, readJson('dummy/album_list.json')),
        );
        // act
        final result = await dataSource.getMyAlbumList(userId);
        // assert
        expect(result.length, equals(tAlbumList.length));
        expect(result[0].id, equals(tAlbumList[0].id));
        expect(result[0].title, equals(tAlbumList[0].title));
      },
    );
  });

  group('get Album Detail Response', () {
    final tAlbumDetail = List<AlbumDetailModel>.from(
      json
          .decode(readJson('dummy/album_detail.json'))
          .map((model) => AlbumDetailModel.fromJson(model)),
    );

    test(
      'should return Album Detail Response when the response code is 200',
      () async {
        // arrange
        dioAdapter.onGet(
          '$BASE_URL/albums_detail?album_id=$albumId',
          (request) => request.reply(200, readJson('dummy/album_detail.json')),
        );
        // act
        final result = await dataSource.getMyAlbumDetailList(albumId);
        // assert
        expect(result.length, equals(tAlbumDetail.length));
        expect(result[0].id, equals(tAlbumDetail[0].id));
        expect(result[0].albumImagePath, equals(tAlbumDetail[0].albumImagePath));
      },
    );
  });
}
