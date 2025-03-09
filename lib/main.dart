import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:valbury_test/app.dart';
import 'package:valbury_test/environment/environment.dart';
import 'package:valbury_test/helper/helper_online_status.dart';
import 'package:valbury_test/screen/album/album_notifier.dart';
import 'package:valbury_test/screen/login/login_notifier.dart';
import 'package:valbury_test/screen/login/login_screen.dart';
import 'package:valbury_test/screen/post/post_notifier.dart';

void main() async {
  Environment.flavorName = 'develop';
  await dotenv.load(fileName: Environment.fileName);
  await App.initDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => App.locator<PostNotifier>()),
        ChangeNotifierProvider(create: (_) => App.locator<AlbumNotifier>()),
        ChangeNotifierProvider(create: (_) => App.locator<LoginNotifier>()),
        ChangeNotifierProvider(create: (_) => App.locator<HelperOnlineStatus>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
