import 'package:flutter_riverpod/flutter_riverpod.dart';

final tickerProvider = StreamProvider<int>((ref) {
  ref.onDispose(() {
    print("[tickerProvider]:: disposed");
  });
  return Stream.periodic(const Duration(seconds: 1), (t) {
    print(t);
    return t + 1;
  }).take(60);
});