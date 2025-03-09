import 'package:valbury_test/domain/entity/post.dart';

class PostModel {
  int? id;
  String? title;
  String? body;
  int? userId;

  PostModel({this.id, this.title, this.body, this.userId});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['user_id'] = userId;
    return data;
  }

  Post toEntity() {
    return Post(
      id: id ?? 0,
      title: title ?? '',
      body: body ?? '',
      userId: userId ?? 0,
      isFavorite: false,
    );
  }
}
