class AlbumDetailModel {
  int? id;
  String? title;
  int? albumId;
  String? albumImagePath;

  AlbumDetailModel({this.id, this.title, this.albumId, this.albumImagePath});

  AlbumDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    albumId = json['album_id'];
    albumImagePath = json['album_image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['album_id'] = albumId;
    data['album_image_path'] = albumImagePath;
    return data;
  }
}
