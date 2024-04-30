import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auto_dispose_family_provider.g.dart';

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

// final counterProvider = Provider.autoDispose.family<int, Counter>((ref,
//     Counter c) {
//   ref.onDispose(() {
//     print('[counterProvider($c)]:: disposed');
//   });
//
//   return c.count;
// },);

// final autoDisPoseFamilyHelloProvider =
// Provider.autoDispose.family<String, String>((ref, name) {
//   print('[autoDisPoseFamilyHelloProvider($name)]:: created');
//   ref.onDispose(() {
//     print('[autoDisPoseFamilyHelloProvider($name)]:: disposed');
//   });
//   return 'Hello $name';
// });

@riverpod
String autoDisPoseFamilyHello(AutoDisPoseFamilyHelloRef ref, String nm) {
  print('[autoDisPoseFamilyHelloProvider($nm)]:: created');
  ref.onDispose(() {
    print('[autoDisPoseFamilyHelloProvider($nm)]:: disposed');
  });
  return 'Hello $nm';
}

@riverpod
int counter(CounterRef ref, Counter c) {
  ref.onDispose(() {
    print('[counterProvider($c)]:: disposed');
  });

  return c.count;
}