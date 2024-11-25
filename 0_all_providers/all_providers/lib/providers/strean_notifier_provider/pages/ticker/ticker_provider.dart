import 'dart:async';

import 'package:all_providers/providers/strean_notifier_provider/timer/ticker.dart';
import 'package:all_providers/providers/strean_notifier_provider/timer/timer_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ticker_provider.g.dart';

@riverpod
class Timer extends _$Timer {
  final int _duration = 10;
  final Ticker _ticker = const Ticker();
  StreamSubscription<int>? _tickerSubscription;

  @override
  Stream<TimerState> build() {
    ref.onDispose(() {
      print('[timerProvider] disposed');
      _tickerSubscription?.cancel();
    },);
    return Stream.value(TimerInitial(_duration));
  }

  // 타이머 시작
  void startTimer() {
    state = AsyncData(TimerRunning(_duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: _duration).listen((duration) {
      state = duration > 0
            ? AsyncData(TimerRunning(duration))
            : const AsyncData(TimerFinished());
      },);
  }

  void pauseTimer() {
    switch (state.value!) {
      case TimerRunning(: int duration):
        _tickerSubscription?.pause();
        state = AsyncData(TimerPaused(duration));
      case _:
    }
  }

  void resumeTime() {
    switch (state.value!) {
      case TimerPaused(: int duration):
        _tickerSubscription?.resume();
        state = AsyncData(TimerRunning(duration));
      case _:
    }
  }

  void resetTimer() {
    _tickerSubscription?.cancel();
    state = AsyncData(TimerInitial(_duration));
  }
}