class ProfileModel {
  String? email;
  String? imagePath;
  int? userId;

  ProfileModel({ this.email, this.imagePath, this.userId});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    imagePath = json['image_path'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['image_path'] = imagePath;
    data['user_id'] = userId;
    return data;
  }
}
