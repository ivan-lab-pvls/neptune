import 'package:auto_route/auto_route.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:neptune/main.dart';
import 'package:neptune/router/router.dart';
import 'package:neptune/screens/prem_screen/prem_screen.dart';
import 'package:neptune/widgets/icon_button.dart';

import '../bloc/audio.dart';

@RoutePage()
class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  String? prem;

  @override
  void initState() {
    super.initState();
    _isPrem();
  }

  Future<void> _isPrem() async {
    final pd = FirebaseRemoteConfig.instance.getString('prem');

    if (!pd.contains('isPrem')) {
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      player.stop();
      setState(() {
        prem = pd;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final audioBloc = BlocProvider.of<AudioBloc>(context);

    if (prem != null) {
      return PremScreen(premIdentifier: prem!);
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg/main_menu.png"),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Stack(
            children: [
              // SvgPicture.asset(
              //   'assets/bg/main_menu.svg',
              //   alignment: Alignment.center,
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height,
              // ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height / 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Neptune ',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      'games',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height / 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          BlocBuilder<AudioBloc, AudioState>(
                            builder: (context, state) {
                              return CustomIconButton(
                                path: state.iconAsset,
                                callback: (_) {
                                  if (state.isPlaying) {
                                    audioBloc.add(AudioEvent.pause);
                                  } else {
                                    audioBloc.add(AudioEvent.play);
                                  }
                                },
                                radius: 16,
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 5 *
                                    MediaQuery.of(context).devicePixelRatio),
                            child: CustomIconButton(
                              path: 'assets/icons/settings.svg',
                              callback: (_) {
                                context.router.push(const SettingsRoute());
                              },
                              radius: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Main menu',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  4 * MediaQuery.of(context).devicePixelRatio),
                          child: ElevatedButton(
                              onPressed: () {
                                context.router.push(const DifficultyRoute());
                              },
                              child: Text(
                                'Start game',
                                style: Theme.of(context).textTheme.displaySmall,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 6),
                          child: ElevatedButton(
                              onPressed: () {
                                FlutterExitApp.exitApp(iosForceExit: true);
                              },
                              child: Text('Exit',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall)),
                        ),
                      ],
                    )),
                    Expanded(child: Container()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
