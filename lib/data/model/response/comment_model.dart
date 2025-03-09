class CommentModel {
  int? id;
  String? body;
  int? postId;

  CommentModel({this.id, this.body, this.postId});

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    postId = json['postId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['body'] = body;
    data['postId'] = postId;
    return data;
  }
}
