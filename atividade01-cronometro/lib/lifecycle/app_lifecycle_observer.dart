import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../viewmodel/stopwatch_viewmodel.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  final BuildContext context;

  AppLifecycleObserver(this.context);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final stopwatchViewModel = Provider.of<StopwatchViewModel>(context, listen: false);

    if (state == AppLifecycleState.paused) {
      if (stopwatchViewModel.isRunning) {
        stopwatchViewModel.startUpdatingNotification();
      }
    } else if (state == AppLifecycleState.resumed) {
      stopwatchViewModel.stopUpdatingNotification();
    }
  }
}
