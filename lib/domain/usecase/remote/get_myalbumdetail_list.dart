import 'package:dartz/dartz.dart';
import 'package:valbury_test/data/model/response/album_detail_model.dart';
import 'package:valbury_test/data/model/response/album_model.dart';
import 'package:valbury_test/domain/repository/app_repository.dart';
import 'package:valbury_test/util/failure.dart';

class GetMyAlbumDetailList {
  final AppRepository _repository;

  GetMyAlbumDetailList(this._repository);

  Future<Either<Failure, List<AlbumDetailModel>>> execute(int albumId) {
    return _repository.getMyAlbumDetailList(albumId);
  }
}
