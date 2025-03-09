import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:get_it/get_it.dart';
import 'package:valbury_test/data/datasource/app_remote_data_source.dart';
import 'package:valbury_test/data/repository/app_repository_impl.dart';
import 'package:valbury_test/domain/repository/app_repository.dart';
import 'package:valbury_test/domain/usecase/remote/get_login.dart';
import 'package:valbury_test/domain/usecase/remote/get_myalbum_list.dart';
import 'package:valbury_test/domain/usecase/remote/get_myalbumdetail_list.dart';
import 'package:valbury_test/domain/usecase/remote/get_mycommentpost_list.dart';
import 'package:valbury_test/domain/usecase/remote/get_mypost_list.dart';
import 'package:valbury_test/helper/helper_online_status.dart';
import 'package:valbury_test/screen/album/album_notifier.dart';
import 'package:valbury_test/screen/login/login_notifier.dart';
import 'package:valbury_test/screen/post/post_notifier.dart';

class App {
  static final locator = GetIt.instance;

  static Future<void> initDI() async {
    var dio = Dio(
        BaseOptions(
          receiveDataWhenStatusError: true,
          connectTimeout: const Duration(milliseconds: 30000),
          receiveTimeout: const Duration(milliseconds: 45000),
          sendTimeout: const Duration(milliseconds: 60000),
          contentType: 'application/json',
          responseType: ResponseType.plain,
        ),
      )
      ..interceptors.add(
        HttpFormatter(
          loggingFilter: (request, response, error) {
            // We don't want to print the request/response when 201 is returned
            if (response?.statusCode == 201) {
              return false;
            }
            // Otherwise, the logs should print
            return true;
          },
        ),
      );

    Connectivity _connectivity = Connectivity();

    locator.registerLazySingleton(() => dio);

    locator.registerLazySingleton(() => _connectivity);

    locator.registerLazySingleton(() => HelperOnlineStatus(locator()));

    locator.registerFactory(() => PostNotifier(locator(), locator()));

    locator.registerFactory(() => AlbumNotifier(locator(), locator()));

    locator.registerFactory(() => LoginNotifier(locator()));

    locator.registerLazySingleton(() => GetMyPostList(locator()));
    locator.registerLazySingleton(() => GetMyAlbumList(locator()));
    locator.registerLazySingleton(() => GetMyCommentPostList(locator()));
    locator.registerLazySingleton(() => GetMyAlbumDetailList(locator()));
    locator.registerLazySingleton(() => GetLogin(locator()));

    locator.registerLazySingleton<AppRepository>(
      () => AppRepositoryImpl(
        remoteDataSource: locator(),
        //localDataSource: locator(),
      ),
    );

    locator.registerLazySingleton<AppRemoteDataSource>(
      () => AppRemoteDataSourceImpl(client: locator()),
    );
  }

  static Future<void> initConnectivity() async {}
}
