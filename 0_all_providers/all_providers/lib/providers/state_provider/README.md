# State Provider
- 간단한 상태를 다룰 때 사용 (primitive, enum)
- 복잡하지 않은 로직을 다룰 때 사용
- 상태를 외부에서 변경하도록 해줌

### StateProvider vs NotifierProvider
StateProvider는 NotifierProvider를 간소화한 버전이다. 
- 매우 간단한 상황에서 사용
- code generation 지원 안함

NotifierProvider는 Notifier class instance를 노출시킨 Provider
- 복잡한 비지니스 로직
- code generation 지원

### StateController<T>
외부에서 state를 변경시킬 수 있는 StateNotifier를 간소화하게 만든 클래스
```dart
// notifier
ref.read(counterProvider.notifier);
// state 접근하여 값 변경
ref.read(counterProvider.notifier).state++;
```


### Compute State with Provider
**ProxyProvider**의 방식과 비슷하지만 간단
하나의 provider가 다른 provider를 통해 값이 변화된다고 가정. 
counterProvider의 상태가 변하면 ageProvider는 값을 계산하기위해 rebuild된다.
counterProvider의 상태가 변하지 않으면 ageProvider는 변하지 않는다. 
```dart
final counterProvider = StateProvider<int>((ref) {
  ref.onDispose(() {
    print('[counterProvider] disposed');
  });
  return 0;
});

@Riverpod(keepAlive: true)
String age(Ref ref) {
  // provider dependency rule - 자동 생성된 riverpod provider는 자동 생성된 provider만 의존할 수 있다.
  // 직접 선언과 자동 생성을 혼용하지 말고 StateProvider를 NotiferProvider로 사용. 혹은 경고 무시
  final age = ref.watch(counterProvider);
  ref.onDispose(() {
    print("[ageProvider] disposed");
  });
  return "Hi! I'm $age years old";
}
```