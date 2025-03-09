import 'package:equatable/equatable.dart';

class Post extends Equatable {
  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.isFavorite,
  });

  final int id;
  final String title;
  final String body;
  final int userId;
  bool isFavorite;

  @override
  List<Object> get props => [id, title, body, userId, isFavorite];
}
