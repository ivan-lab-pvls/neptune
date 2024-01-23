import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:neptune/const/core/config.dart';
import 'package:neptune/const/core/notys.dart';

import 'bloc/audio.dart';
import 'router/router.dart';

final player = AudioPlayer();

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: AppFirebaseOptions.currentPlatform);

  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 9),
    minimumFetchInterval: const Duration(seconds: 9),
  ));

  await FirebaseRemoteConfig.instance.fetchAndActivate();

  await NotificationsFirebase().activate();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  player.setAsset('assets/music.mp3');
  player.play();
  player.playerStateStream.listen((state) {
    if (state.processingState == ProcessingState.completed) {
      player.seek(Duration.zero);
      player.play();
    }
  });
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: AudioBloc(player: player),
        ),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return MaterialApp.router(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(50, 145, 166, 1),
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(57, 174, 200, 1),
          size: 24,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(
                fontSize: isTablet ? 24 : 16,
                color: Colors.white,
              ),
            ),
            elevation: MaterialStateProperty.all<double>(0),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.all(10),
            ),
            minimumSize: MaterialStateProperty.all<Size>(
              const Size(241, 48),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              Color.fromRGBO(57, 174, 200, 1),
            ),
          ),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'Roboto',
            fontSize: isTablet ? 48 : 32,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
          displayMedium: TextStyle(
            fontFamily: 'Roboto',
            fontSize: isTablet ? 36 : 24,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
          displaySmall: TextStyle(
            fontFamily: 'Roboto',
            fontSize: isTablet ? 24 : 16,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
    );
  }
}
