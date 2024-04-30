import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_provider.g.dart';

// family 생성자로 유사한 Provider를 만드는 행위를 줄일 수 있음
// Provider.family<T, R> : T return Type, R receive Type
// final familyHelloProvider = Provider.family<String, String>((ref, name) {
//   ref.onDispose(() {
//     print('[familyHelloProvider($name)]:: disposed');
//   });
//   return 'Hello $name';
// });

// 추가적인 Arugment만 주면 family로 생성
// 자동 생성 코드에 `name`의 변수가 따로 생성되므로
// argument 이름은 `name`으로 하면 안됨.
@Riverpod(keepAlive: true)
String familyHello (FamilyHelloRef ref, {required String myName}) {
  ref.onDispose(() {
    print('[familyHelloProvider($myName)]:: disposed');
  });
  return 'Hello $myName';
}