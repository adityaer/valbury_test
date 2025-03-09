import 'package:valbury_test/data/model/response/comment_model.dart';
import 'package:valbury_test/domain/entity/post.dart';
import 'package:valbury_test/domain/usecase/remote/get_mycommentpost_list.dart';
import 'package:valbury_test/domain/usecase/remote/get_mypost_list.dart';
import 'package:valbury_test/helper/helper_enum.dart';
import 'package:valbury_test/screen/base/base_notifier.dart';

class PostNotifier extends BaseNotifier {
  final GetMyPostList _getMyPostList;
  final GetMyCommentPostList _getMyCommentPostList;

  PostNotifier(this._getMyPostList, this._getMyCommentPostList);

  List<Post> _postList = [];

  List<Post> get postList => _postList;

  List<Post> _postFavoriteList = [];

  List<Post> get postFavoriteList => _postFavoriteList;

  List<CommentModel> _commentPostList = [];

  List<CommentModel> get commentPostList => _commentPostList;

  RequestState statePostList = RequestState.empty;

  void resetData() {}

  Future<void> fetchPostList(int userId) async {
    statePostList = RequestState.loading;
    notifyListeners();

    final result = await _getMyPostList.execute(userId);

    result.fold(
      (failure) {
        setMessage(failure.message);
        statePostList = RequestState.error;
        notifyListeners();
      },
      (data) {
        _postList.clear();
        _postList.addAll(data);

        statePostList = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchCommentPostList(int postId) async {
    statePostList = RequestState.loading;
    notifyListeners();

    final result = await _getMyCommentPostList.execute(postId);

    result.fold(
      (failure) {
        setMessage(failure.message);
        statePostList = RequestState.error;
        notifyListeners();
      },
      (data) {
        _commentPostList.clear();
        _commentPostList.addAll(data);

        statePostList = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  void updateFavoritePost(Post postFavorite) {
    for (var data in _postList) {
      if (postFavorite.id == data.id) {
        data.isFavorite = !data.isFavorite;

        if (!data.isFavorite) {
          _postFavoriteList.remove(data);
        } else {
          _postFavoriteList.add(data);
        }

        break;
      }
    }

    postList.sort((a, b) {
      if (a.isFavorite == b.isFavorite) {
        return a.id.compareTo(b.id);
      }

      return a.isFavorite ? -1 : 1;
    });

    notifyListeners();
  }
}
