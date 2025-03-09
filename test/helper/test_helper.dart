import 'package:mockito/annotations.dart';
import 'package:valbury_test/data/datasource/app_remote_data_source.dart';
import 'package:valbury_test/domain/repository/app_repository.dart';
import 'package:valbury_test/screen/album/album_notifier.dart';
import 'package:valbury_test/screen/post/post_notifier.dart';

@GenerateMocks([
  AppRepository,
  AppRemoteDataSource,
  PostNotifier,
  AlbumNotifier,
])

void main() {}
