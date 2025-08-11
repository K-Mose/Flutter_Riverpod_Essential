sealed class TimerState {
  final int duration;
  const TimerState(this.duration);
}

final class TimerInitial extends TimerState {
  const TimerInitial(super.duration);

  @override
  String toString() {
    return 'TimerInitial{duration: $duration}';
  }
}

class TimerRunning extends TimerState {
  const TimerRunning(super.duration);

  @override
  String toString() {
    return 'TimerRunning{duration: $duration}';
  }
}

class TimerPaused extends TimerState {
  const TimerPaused(super.duration);

  @override
  String toString() {
    return 'TimerPaused{duration: $duration}';
  }
}

class TimerFinished extends TimerState {
  const TimerFinished() : super(0);

  @override
  String toString() {
    return 'TimerFinished{duration: $duration}';
  }
}