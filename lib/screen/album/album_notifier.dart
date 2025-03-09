import 'package:valbury_test/data/model/response/album_detail_model.dart';
import 'package:valbury_test/domain/entity/album.dart';
import 'package:valbury_test/domain/usecase/remote/get_myalbum_list.dart';
import 'package:valbury_test/domain/usecase/remote/get_myalbumdetail_list.dart';
import 'package:valbury_test/helper/helper_enum.dart';
import 'package:valbury_test/screen/base/base_notifier.dart';

class AlbumNotifier extends BaseNotifier {
  final GetMyAlbumList _getMyAlbumList;

  final GetMyAlbumDetailList _getMyAlbumDetailList;

  AlbumNotifier(this._getMyAlbumList, this._getMyAlbumDetailList);

  List<Album> _albumList = [];

  List<Album> get albumList => _albumList;

  List<Album> _albumFavoriteList = [];

  List<Album> get albumFavoriteList => _albumFavoriteList;

  List<AlbumDetailModel> _albumDetailList = [];

  List<AlbumDetailModel> get albumDetailList => _albumDetailList;

  RequestState stateAlbumList = RequestState.empty;

  void resetData() {}

  Future<void> fetchAlbumList(int userId) async {
    stateAlbumList = RequestState.loading;
    notifyListeners();

    final result = await _getMyAlbumList.execute(userId);

    result.fold(
      (failure) {
        setMessage(failure.message);
        stateAlbumList = RequestState.error;
        notifyListeners();
      },
      (data) {
        _albumList.clear();
        _albumList.addAll(data);

        stateAlbumList = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchAlbumDetailList(int albumId) async {
    stateAlbumList = RequestState.loading;
    notifyListeners();

    final result = await _getMyAlbumDetailList.execute(albumId);

    result.fold(
      (failure) {
        setMessage(failure.message);
        stateAlbumList = RequestState.error;
        notifyListeners();
      },
      (data) {
        _albumDetailList.clear();
        _albumDetailList.addAll(data);

        stateAlbumList = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  void updateFavoriteAlbum(Album album) {
    for (var data in _albumList) {
      if (album.id == data.id) {
        data.isFavorite = !data.isFavorite;

        if (!data.isFavorite) {
          _albumFavoriteList.remove(data);
        } else {
          _albumFavoriteList.add(data);
        }

        break;
      }
    }

    albumList.sort((a, b) {
      if (a.isFavorite == b.isFavorite) {
        return a.id.compareTo(b.id);
      }

      return a.isFavorite ? -1 : 1;
    });

    notifyListeners();
  }
}
