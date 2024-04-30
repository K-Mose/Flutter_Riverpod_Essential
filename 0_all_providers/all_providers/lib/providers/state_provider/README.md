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
ref.read(counterProvider.notifier);
```

ref