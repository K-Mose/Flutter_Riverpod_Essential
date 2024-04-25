import 'package:flutter_riverpod/flutter_riverpod.dart';

final autoDisPoseFamilyHelloProvider =
    Provider.autoDispose.family<String, String>((ref, name) {
  print('[autoDisPoseFamilyHelloProvider($name)]:: created');
  ref.onDispose(() {
    print('[autoDisPoseFamilyHelloProvider($name)]:: disposed');
  });
  return 'Hello $name';
});