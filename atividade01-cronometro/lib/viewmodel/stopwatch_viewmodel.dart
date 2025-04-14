import 'dart:async';
import 'package:flutter/material.dart';
import 'notification_viewmodel.dart';

class StopwatchViewModel extends ChangeNotifier {
  late Stopwatch _stopwatch;
  Timer? _timer;
  Timer? _pauseTimer;
  Timer? _backgroundTimer;

  String _elapsedTime = '00:00.00';
  List<Map<String, String>> _laps = [];

  final NotificationViewModel _notificationViewModel = NotificationViewModel();

  StopwatchViewModel() {
    _stopwatch = Stopwatch();
    _notificationViewModel.initialize();
  }

  String get elapsedTime {
    final ms = _stopwatch.elapsedMilliseconds;
    final minutes = (ms ~/ 60000).toString().padLeft(2, '0');
    final seconds = ((ms % 60000) ~/ 1000).toString().padLeft(2, '0');
    final hundredths = ((ms % 1000) ~/ 10).toString().padLeft(2, '0');
    return '$minutes:$seconds.$hundredths';
  }

  bool get isRunning => _stopwatch.isRunning;

  double get progress {
    final max = 60000.0;
    return (_stopwatch.elapsedMilliseconds % max) / max;
  }

  List<Map<String, String>> get laps => _laps;

  void _updateTime() {
    _elapsedTime = elapsedTime;
    notifyListeners();
  }

  void start() {
    _stopwatch.start();
    _timer = Timer.periodic(
      Duration(milliseconds: 30),
          (_) => _updateTime(),
    );
    _pauseTimer?.cancel();
    _notificationViewModel.showCronometroAtivo();
    startUpdatingNotification();
    notifyListeners();
  }

  void pause() {
    _stopwatch.stop();
    _timer?.cancel();

    _pauseTimer = Timer(Duration(seconds: 10), () {
      if (!_stopwatch.isRunning) {
        _notificationViewModel.showCronometroInativo();
      }
    });

    _backgroundTimer?.cancel();
    notifyListeners();
  }

  void reset() {
    _stopwatch.reset();
    _timer?.cancel();
    _pauseTimer?.cancel();
    _backgroundTimer?.cancel();
    _laps.clear();
    _elapsedTime = '00:00.00';
    notifyListeners();
  }

  void addLap() {
    final current = elapsedTime;
    final totalMs = _stopwatch.elapsedMilliseconds;

    int sumOfPreviousLapsMs = 0;
    for (var lap in _laps) {
      final parts = lap['lap']!.split(RegExp(r'[:.]'));
      final min = int.parse(parts[0]);
      final sec = int.parse(parts[1]);
      final hun = int.parse(parts[2]);
      sumOfPreviousLapsMs += min * 60000 + sec * 1000 + hun * 10;
    }

    final lapMs = totalMs - sumOfPreviousLapsMs;
    final lapMinutes = (lapMs ~/ 60000).toString().padLeft(2, '0');
    final lapSeconds = ((lapMs % 60000) ~/ 1000).toString().padLeft(2, '0');
    final lapHundredths = ((lapMs % 1000) ~/ 10).toString().padLeft(2, '0');
    final lapTime = '$lapMinutes:$lapSeconds.$lapHundredths';

    _laps.add({
      'lap': lapTime,
      'total': current,
    });

    _notificationViewModel.showVoltaRegistrada(
      lapTime: lapTime,
      totalTime: current,
    );

    notifyListeners();
  }

  void startUpdatingNotification() {
    _backgroundTimer?.cancel();
    _backgroundTimer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_stopwatch.isRunning) {
        _notificationViewModel.showCronometroAtivoComTempo(elapsedTime);
      } else {
        _backgroundTimer?.cancel();
      }
    });
  }

  void stopUpdatingNotification() {
    _backgroundTimer?.cancel();
  }
}
