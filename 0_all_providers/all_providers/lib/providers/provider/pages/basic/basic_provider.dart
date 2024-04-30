// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'basic_provider.g.dart';

// final helloProvider = Provider<String>((ref) {
//   // Provider가 dispose될 때 실행
//   ref.onDispose(() {
//     // 해당 Provider를 필요로하는 Provider나 Widget이 없을 때 Dispose 될 수 있음
//     print('[helloProvider]:: disposed');
//   });
//   return "Hello";
// });
//
// final worldProvider = Provider<String>((ref) {
//   ref.onDispose(() {
//     print('[worldProvider]:: disposed');
//   });
//   return "World";
// });

// code generation에서 helloProvider를 생성
// Ref 타입은 함수 이름을 파스칼 케이스로 표시
@Riverpod(keepAlive: true)
String hello (HelloRef ref) {
  ref.onDispose(() {
    print('[helloProvider]:: disposed');
  });
  return "Hello";
}

@Riverpod(keepAlive: true)
String world (WorldRef ref){
  ref.onDispose(() {
    print('[worldProvider]:: disposed');
  });
  return "World";
}