import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:valbury_test/data/model/response/album_model.dart';
import 'package:valbury_test/data/model/response/post_model.dart';
import 'package:valbury_test/data/repository/app_repository_impl.dart';
import 'package:valbury_test/domain/entity/album.dart';
import 'package:valbury_test/domain/entity/post.dart';
import 'package:valbury_test/util/exception.dart';
import 'package:valbury_test/util/failure.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late AppRepositoryImpl repository;
  late MockAppRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAppRemoteDataSource();
    repository = AppRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  final tPostModelList = [PostModel()];

  var tPost = Post(id: 0, title: '', userId: 0, body: '', isFavorite: false);

  var tPostList = [tPost];

  final tAlbumModelList = [AlbumModel()];

  var tAlbum = Album(
    id: 0,
    albumImagePath: '',
    title: '',
    userId: 0,
    isFavorite: false,
  );

  var tAlbumList = [tAlbum];

  group('Post List', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getMyPostList(1),
        ).thenAnswer((_) async => tPostModelList);
        // act
        final result = await repository.getMyPostList(1);
        // assert
        verify(mockRemoteDataSource.getMyPostList(1));
        final resultList = result.getOrElse(() => []);
        expect(resultList, tPostList);
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getMyPostList(1),
        ).thenThrow(ServerException(''));
        // act
        final result = await repository.getMyPostList(1);
        // assert
        verify(mockRemoteDataSource.getMyPostList(1));
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected to internet',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getMyPostList(1),
        ).thenThrow(const SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getMyPostList(1);
        // assert
        verify(mockRemoteDataSource.getMyPostList(1));
        expect(
          result,
          equals(
            const Left(ConnectionFailure('Failed to connect to the network')),
          ),
        );
      },
    );
  });

  group('Album List', () {
    test(
      'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(
          mockRemoteDataSource.getMyAlbumList(1),
        ).thenAnswer((_) async => tAlbumModelList);
        // act
        final result = await repository.getMyAlbumList(1);
        // assert
        verify(mockRemoteDataSource.getMyAlbumList(1));
        final resultList = result.getOrElse(() => []);
        expect(resultList, tAlbumList);
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(
          mockRemoteDataSource.getMyAlbumList(1),
        ).thenThrow(ServerException(''));
        // act
        final result = await repository.getMyAlbumList(1);
        // assert
        verify(mockRemoteDataSource.getMyAlbumList(1));
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected to internet',
          () async {
        // arrange
        when(
          mockRemoteDataSource.getMyAlbumList(1),
        ).thenThrow(const SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getMyAlbumList(1);
        // assert
        verify(mockRemoteDataSource.getMyAlbumList(1));
        expect(
          result,
          equals(
            const Left(ConnectionFailure('Failed to connect to the network')),
          ),
        );
      },
    );
  });
}
