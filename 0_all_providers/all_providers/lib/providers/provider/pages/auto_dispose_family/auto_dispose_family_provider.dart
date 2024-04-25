import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Counter extends Equatable {
  final int count;

  const Counter({
    required this.count,
  });

  @override
  List<Object> get props => [count];

  @override
  String toString() {
    return 'Counter{count: $count}';
  }
}

final counterProvider = Provider.autoDispose.family<int, Counter>((ref,
    Counter c) {
  ref.onDispose(() {
    print('[counterProvider($c)]:: disposed');
  });

  return c.count;
},);

final autoDisPoseFamilyHelloProvider =
Provider.autoDispose.family<String, String>((ref, name) {
  print('[autoDisPoseFamilyHelloProvider($name)]:: created');
  ref.onDispose(() {
    print('[autoDisPoseFamilyHelloProvider($name)]:: disposed');
  });
  return 'Hello $name';
});