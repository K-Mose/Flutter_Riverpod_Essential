# all_providers

**riverpod의 9가지 Provider**
1. [Provider](#provider)
2. StateProvider
3. StateNotifierProvider
4. ChangeNotifierProvider
5. NotifierProvider
6. AsyncNotifierProvider
7. FutureProvider
8. StreamProvider
9. StreamNotifierProvider

**Provider Modifiers**
- none
- autoDispose
- family 
- autoDispose + family
![](../../imgs/provider_modifiers.png)

**위젯에서 ref 접근하기**
1. `extends Consumer`
2. `extends ConsumerWidget`
3. `extends ConsumerStatefulWidget`

ref
- watch : 값 변경이 필요한 state 
- listen : dialog, navigating같은 액션이 필요한 state
- read : 값 변경이 필요없는 state

## <a id="provider"/> 1. Provider
- `Provider`는 riverpod에서 제공히는 provider들 중에서 가장 기본 
- `Provider`는 값을 생성함(생성밖에 못함)
- 기본적인 용도는 위젯이나 다른 `Provider`에게 값을 제공

### Provider for value overriding 
1. 개발에는 FakeRepository, 배포에는 RealRepository 사용
2. 비동기식으로 initial이 필요한 인스턴스를 Provider로 제공
3. 성능 최적화. rebuild 할 요소들을 최소화 시킴

기본 Provider 생성
```dart
final helloProvider = Provider<String>((ref) {
  return "hello!";
});
```
변수는 항상 global final 변수로 Provider가 관리하는 state를 접근.
`Provider<T>` Provider가 관리하는 데이터의 타입을 지정.
ref, 다른 Provider에 접근하거나 Provider를 Dispose 시키는 등 다양한 작업
> Provider Package와 차이점: Provier는 위젯으로 항상 위젯트리 내에서만 존재. Riverpod의 Provider는 위젯이 아닌 dart object로 global final variable로 선언, 앱을 `ProviderScope`로 감쌈. dart object이므로 flutter 외 dart에서도 사용 가능
> 사용하는 Provider를 변경하면 제공하는 Provider가 달라져 앱에서 상태 값에 접근하고 상호작용 하는 방법이 달라짐

### autoDispose
```dart
final autoDisposeHelloProvider = Provider.autoDispose<String>((ref)  {
  print('[autoDisposeHelloProvider]:: created');
  ref.onDispose(() {
    print('[autoDisposeHelloProvider]:: disposed');
  });
  return 'Hello';
});
```
provider를 `Provider.autoDispose`로 생성시키면 해당 상태를 사용하는 widget, provider가 없으면 자동으로 dispose하고 사용하면 create 한다.

-> 자주 바뀌는 상태에서는 괜찮지만 상태를 계속 유지해야 하는 `Provider`에서는 좋지 않다

### family
주어진 아규먼트에 따라서 갑이 바뀌는 Provider를 제공할 때 사용
```dart
final familyHelloProvider = Provider.family<String, String>((ref, name) {
  ref.onDispose(() {
    print('[familyHelloProvider($name)]:: disposed');
  });
  return 'Hello $name';
});
```
name으로 주어지는 변수에 따라서 출력값이 딸라진다.
Provider.family<T, R> : T는 반환 타입, R은 아규먼트로 받는 타입.
`ref.watch(familyHelloProvider('Jane'));`와 같이 값을 주어 호출한다.

### autoDispose + family
각 modifier를 연속으로 호출하여 사용한다.
사용은 family와 같으며 autoDispose의 기능이 사용된다.
```dart
final autoDisPoseFamilyHelloProvider =
    Provider.autoDispose.family<String, String>((ref, name) {
  print('[autoDisPoseFamilyHelloProvider($name)]:: created');
  ref.onDispose(() {
    print('[autoDisPoseFamilyHelloProvider($name)]:: disposed');
  });
  return 'Hello $name';
});
```

```dart
    final helloJohn = ref.watch(autoDisPoseFamilyHelloProvider('John'));
    final helloJane = ref.watch(autoDisPoseFamilyHelloProvider('John'));
```
같은 값을 받는 Provider를 호출하게 된다면 Provider는 같은 객체로 보고 하나만 출력한다.
```text
I/flutter ( 6107): [autoDisPoseFamilyHelloProvider(John)]:: created
```