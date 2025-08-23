# [Provider Observer](https://riverpod.dev/docs/concepts2/observers)
App에서 사용되는 여러 provider의 lifecycle 및 이벤트에 대해서 관찰하면서 주로 로깅, 분석, 디버깅에 사용된다.  

**ProviderObserver**
- Provider가 언제 initialized 됐는지 
- Provider가 언제 disposed 됐는지
- Provider가 언제 state의 변화가 일어났는지

### Usage
Provider Observer를 사용하기 이해서는 `ProviderObserver`를 `extends`하는 Class를 만들어야 한다.   
- didAppProvider : Provider가 초기화될 때 호출됨 (다른 provider/widget에 의해서 watch/listen/read 할 때)
- didDisposeProvider : Provider가 dispose 될 때 호출됨 (autoDispose 또는 listen이 없을 때) 
- didUpdateProvider : state의 변화가 일어났을 때.

```dart
/// Logger 예제
class Logger extends ProviderObserver {
  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value, ProviderContainer container) {
    print('''
{
  "provider" : ${provider.name ?? provider.runtimeType} is initialized",
  "value exposed" : "$value"
}
''');
  }

  @override
  void didDisposeProvider(ProviderBase<Object?> provider, ProviderContainer container) {
    print(''''
{
  "provider" : ${provider.name ?? provider.runtimeType} is disposed",
}
    ''');
  }

  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue, Object? newValue, ProviderContainer container) {
    print('''
{
  "provider" : ${provider.name ?? provider.runtimeType} is updated",
  "previous value" : "$previousValue"
  "new value" : "$newValue" 
}    
    ''');
  }  
  
}


/// main에 logger 추가 
void main() {
  runApp(
    ProviderScope(
      observers: [Logger()],
      child: const MyApp(),
    ),
  );
}
```