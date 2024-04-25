import 'package:riverpod_annotation/riverpod_annotation.dart';

// autoDispose 생성자를 사용하여 autoDispose 되는 Provider로 생성
// 이전 값을 유지하지 않아되 되는 위젯에서 사용
final autoDisposeHelloProvider = Provider.autoDispose<String>((ref)  {
  print('[autoDisposeHelloProvider]:: created');
  ref.onDispose(() {
    print('[autoDisposeHelloProvider]:: disposed');
  });
  return 'Hello';
});