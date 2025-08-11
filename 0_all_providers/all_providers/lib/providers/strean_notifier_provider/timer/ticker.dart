class Ticker {
  const Ticker();

  /// [ticks] is Timer's initial seconds
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x -1,).take(ticks);
  }

}