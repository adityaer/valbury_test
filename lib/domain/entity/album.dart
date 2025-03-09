import 'package:equatable/equatable.dart';

class Album extends Equatable {
  Album({
    required this.id,
    required this.title,
    required this.userId,
    required this.albumImagePath,
    required this.isFavorite,
  });

  final int id;
  final String title;
  final int userId;
  final String albumImagePath;
  bool isFavorite;

  @override
  List<Object> get props => [id, title, userId, albumImagePath, isFavorite];
}
