import 'package:valbury_test/domain/entity/album.dart';

class AlbumModel {
  int? id;
  String? title;
  int? userId;
  String? albumImagePath;

  AlbumModel({this.id, this.title, this.userId, this.albumImagePath});

  AlbumModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    userId = json['user_id'];
    albumImagePath = json['album_image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['user_id'] = userId;
    data['album_image_path'] = albumImagePath;
    return data;
  }

  Album toEntity() {
    return Album(
      id: id ?? 0,
      albumImagePath: albumImagePath ?? '',
      title: title ?? '',
      userId: userId ?? 0,
      isFavorite: false,
    );
  }
}
