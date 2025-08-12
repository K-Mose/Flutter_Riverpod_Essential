# [Provider LifeCycle](https://riverpod.dev/docs/concepts/provider_lifecycles)

![lifecycle_map.png](./lifecycle_map.png)

- Uninitialized/Disposed: Provider가 아무 리소스도 할당받지 못한 상태
  - Creating -> Alive : build Function이 실행 되고 Provider의 상태는 ProviderScope에 저장됨 
- Alive : Widget 또는 다른 Provider에 의해서 watch/listen 되고 있는 상태 
  - Alive에서 state가 변함에 따라 의존하는 Widget/Provider이 rebuild 됨
  - KeepAlive에 따라서 Paused(true) / Disposed(false) 로 변한다. 
- Paused : Alive Provider가 다른 Widget/Provider에 의헤 listen 되지 않을 때 
  - Alive <-> Paused : Provider를 listen이 되어지거나 되어지지 않을 때 상태 변화 
- Disposed : 메모리에서 제거되고, 리소스를 할당받지 않은 상태
  - Alive -> Disposed / Paused -> Disposed로 상태가 변한다.  
  - Disposed 되는 3가지 이유
    - autoDispose에 의해서 
    - invalidate/refresh에 의해서
    - watch/listen하는 Provider의 state 변화에 의해서 

## Ref에서 제공하는 LifeCycle Methods
![lifecycle_methods.png](./lifecycle_methods.png)


## Caching Provider
![caching_provider.png](./caching_provider.png)
1. autoDispose되는 Provider
2. KeepAlive
3.  ref.keepAlive()와 Timer를 이용해서 일정 시간이 지나면 Dispose되는 Provider 


## LifeCycle Test
### 1, keepAlive: false (AutoDispose)
AutoDispose일 때 lifecycle
`ref.watch(autoDisposeCoutner)`를 통해서  initialized되고 listener가 추가된다. 
화면을 나가게되면 listener가 해제되고 Provider가 cancel, dispose 된다.
```
I/flutter (19199): [AutoDisposeCounter] initialized
I/flutter (19199): [AutoDisposeCounter] listener added
I/flutter (19199): [AutoDisposeCounter] listener removed
I/flutter (19199): [AutoDisposeCounter] cancelled
I/flutter (19199): [AutoDisposeCounter] disposed
```

### 2. keepAlive: true
provider를 listen하는 화면에서 나오면 listener가 제거되고, Provider는 취소된다. 
그리고 화면으로 재진입 하게 되면 listener를 다시 추가하고, Provider는 resume한다. 
```
// provider 초기화
I/flutter (19199): [KeepAliveCounterProvider] initialized
I/flutter (19199): [KeepAliveCounterProvider] listener added

// provider를 listen하는 화면에서 나왔을 때 
I/flutter (19199): [KeepAliveCounterProvider] listener removed
I/flutter (19199): [KeepAliveCounterProvider] cancelled

// provider를 listen하는 화면으로 재진입
I/flutter (19199): [KeepAliveCounterProvider] listener added
I/flutter (19199): [KeepAliveCounterProvider] resumed
```

### 3. keepAlive: false + ref.keepAlive() + Timer + lifecycle methods (sync)
지금까지는 Provider가 autoDispose되거나 엡이 종료될 때 까지 KeepAlive 하는 상황을 봤다.

하지만 앱이 실행되고 있을 때 Provider의 state 변화가 일정 시간동안 없으면 종료되는 Provider를 만들 고 싶을 떄 캐싱 할 수 있다.

**KeepAliveLink + Timer**를 통한 캐싱
`onCancel`에서 timer를 실행시키고, `onDispose` 또는 `onResume`에서 Timer를 해제시킨다. 

캐시가 종료되면 `onDispose`이고, 캐시를 유지한 채 다시 시작되면 `onResume`이 시작된다.
```dart
@riverpod
class SyncKeepAliveCounter extends _$SyncKeepAliveCounter {
  @override
  int build() {
    // keepAlvie 메소드는 KeepAliveLink 객체를 반환한다.
    final keepAliveLink = ref.keepAlive();
    Timer? timer;
    Timer? timer2;
    ref.onDispose(() {
      print('[SyncKeepAliveCounterProvider] disposed, timer canceled');
      // Provider가 close되면 dispose 되므로 timer를 취소시킨다.
      timer?.cancel();
      timer2?.cancel();
      timer = null;
    });
    ref.onCancel(() {
      print('[SyncKeepAliveCounterProvider] cancelled, timer started');
      // Provier의 listener가 사라진 경우 cancel이 호출되므로
      // cancel이 호출된 시점 이후에 타이머를 실행시켜 Provider를 close할 수 있다.
      timer2 = Timer.periodic(const Duration(seconds: 1), (time) {
        print(time.tick);
      },);
      timer = Timer(const Duration(seconds: 10), () {
        keepAliveLink.close();
      });
    });
    ref.onResume(() {
      print('[SyncKeepAliveCounterProvider] resumed, timer canceled');
      // cancel에서 resume으로 돌아가기 때문에 resume에서 timer를 취소시킨다.
      timer?.cancel();
      timer2?.cancel();
      timer = null;
    });
    ref.onAddListener(() {
      print('[SyncKeepAliveCounterProvider] listener added');
    });
    ref.onRemoveListener(() {
      print('[SyncKeepAliveCounterProvider] listener removed');
    });
    print('[SyncKeepAliveCounterProvider] initialized');
    return 0;
  }

  void increment() => state++;
}
```

로그를 확인하면 아래와 같다. 
```
// provider 초기화
I/flutter (19199): [SyncKeepAliveCounterProvider] initialized
I/flutter (19199): [SyncKeepAliveCounterProvider] listener added

// listen 해제, cancel
I/flutter (19199): [SyncKeepAliveCounterProvider] listener removed
I/flutter (19199): [SyncKeepAliveCounterProvider] cancelled, timer started
I/flutter (19199): 1
I/flutter (19199): 2
I/flutter (19199): 3
I/flutter (19199): 4

// listen 시작, resume
I/flutter (19199): [SyncKeepAliveCounterProvider] listener added
I/flutter (19199): [SyncKeepAliveCounterProvider] resumed, timer canceled

// listen 해제, cancel, 10초 후 dispose
I/flutter (19199): [SyncKeepAliveCounterProvider] listener removed
I/flutter (19199): [SyncKeepAliveCounterProvider] cancelled, timer started
I/flutter (19199): 1
I/flutter (19199): 2
I/flutter (19199): 3
I/flutter (19199): 4
I/flutter (19199): 5
I/flutter (19199): 6
I/flutter (19199): 7
I/flutter (19199): 8
I/flutter (19199): 9
I/flutter (19199): 10
I/flutter (19199): [SyncKeepAliveCounterProvider] disposed, timer canceled
```

### 4. keepAlive: false + ref.keepAlive() + Timer + lifecycle methods (async)

### 5. when a provider watches another provider