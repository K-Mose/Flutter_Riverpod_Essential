# StreamNotifierProvider
`StreamProvider`는 stream value를 처리하는데 사용됨. 사용자와의 상호작용 등 복잡한 비즈니스 로직의 처리가 필요하면 `StreamNotifierProvider`를 사용한다.

`StreamNotifierProvider`는 `StreamNotifier`를 **expose**하고 **listen**한다.
- `StreamNotifierProvider`은 build function에서 stream을 생성할 수 있는 `AsyncNotifier`의 변형이다.
- `StreamNotifier`안에서는 `AsyncValue`타입의 새로운 상태를 발생시키는 함수들을 만들 수 있다.
- `StreamNotifier`에는 `Notifier`와 `AsyncNotifier`와 마찬가지로 `ref` 객체가 property로 존재한다.


### Modifier 적용
**autoDispose**
`AutoDispose modifier`를 적용하기 위해서는 `AutoDisposeStreamNotifier`를 사용한다. 
**family**
`Family modifier`를 적용하기 위해서는 `FamilyStreamNotifier`를 사용한다. 
**autoDispose.family**
`Family modifier`를 적용하기 위해서는 `AutoDisposeFamilyStreamNotifier`를 사용한다. 

### AsyncNotifierProvider 와의 차이점 
`StreamNotifierProvider`와 `AsyncNotifierProvider`의 차이점은 `Build`에서 **Stream**을 반환하느냐 또는 **Future**를 반환하느냐 차이밖에 없다.
일반적으로 `NotifierProvider`의 사용이 선호된다. 