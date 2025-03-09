import 'package:dartz/dartz.dart';
import 'package:valbury_test/data/model/response/album_model.dart';
import 'package:valbury_test/domain/entity/album.dart';
import 'package:valbury_test/domain/repository/app_repository.dart';
import 'package:valbury_test/util/failure.dart';

class GetMyAlbumList {
  final AppRepository _repository;

  GetMyAlbumList(this._repository);

  Future<Either<Failure, List<Album>>> execute(int userId) {
    return _repository.getMyAlbumList(userId);
  }
}
