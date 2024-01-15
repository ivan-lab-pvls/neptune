import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neptune/const/color.dart';

import '../bloc/audio.dart';
import '../bloc/game.dart';
import '../router/router.dart';
import '../timer/timer_bloc.dart';
import '../widgets/icon_button.dart';

class Sx extends StatefulWidget {
  const Sx({super.key, required this.sad});
  final String sad;

  @override
  State<Sx> createState() => _SxState();
}

class _SxState extends State<Sx> {
  var _progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            InAppWebView(
              onLoadStop: (controller, url) {
                controller.evaluateJavascript(
                    source:
                        "javascript:(function() { var ele=document.getElementsByClassName('docs-ml-header-item docs-ml-header-drive-link');ele[0].parentNode.removeChild(ele[0]);var footer = document.getelementsbytagname('footer')[0];footer.parentnode.removechild(footer);})()");
              },
              onProgressChanged: (controller, progress) => setState(() {
                _progress = progress;
              }),
              initialUrlRequest: URLRequest(
                url: Uri.parse(widget.sad),
              ),
            ),
            if (_progress != 100)
              Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


@RoutePage()
class PauseScreen extends StatelessWidget {
  final TimerBloc timerBloc;
  final GameBloc gameBloc;

  const PauseScreen({Key? key, required this.timerBloc, required this.gameBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioBloc = BlocProvider.of<AudioBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 20),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: 5 * MediaQuery.of(context).devicePixelRatio),
                      child: BlocBuilder<AudioBloc, AudioState>(
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
                    ),
                    CustomIconButton(
                      path: 'assets/icons/settings.svg',
                      callback: (_) {
                        context.router.push(const SettingsRoute());
                      },
                      radius: 16,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Pause',
                      style: Theme.of(context).textTheme.displayLarge),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 4 * MediaQuery.of(context).devicePixelRatio),
                    child: ElevatedButton(
                        onPressed: () {
                          timerBloc.add(const TimerResumed(1));
                          context.router.pop();
                        },
                        child: Text('Continue',
                            style: Theme.of(context).textTheme.displaySmall)),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        gameBloc.add(GameRestartEvent());
                      },
                      child: Text('Restart',
                          style: Theme.of(context).textTheme.displaySmall)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 4 * MediaQuery.of(context).devicePixelRatio),
                    child: ElevatedButton(
                        onPressed: () {
                          context.router.pushAndPopUntil(
                            MainMenuRoute(),
                            predicate: (_) => false,
                          );
                        },
                        child: Text('To main',
                            style: Theme.of(context).textTheme.displaySmall)),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        FlutterExitApp.exitApp(iosForceExit: true);
                      },
                      child: Text('Exit',
                          style: Theme.of(context).textTheme.displaySmall)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
