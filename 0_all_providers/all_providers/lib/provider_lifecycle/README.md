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
사용자가 request 완료 전에 cancel 시키는 상황 (뒤로가기 등)
Dio에서 제공하는 cancelToken을 이용하면 된다.

CancelToken을 Dio에 등록하고 request를 취소할 시점에서 `cancelToekn.cancel()`을 실행시킨다. 
```dart
@riverpod
FutureOr<List<Product>> getProducts(GetProductsRef ref) async {
  // CancelToken - Dio에서 request 취소를 확인 할 수 있는 객체
  final cancelToken = CancelToken();
  Timer? timer;

  ref.onDispose(() {
    print('[getProductsProvider] disposed, token canceled');
    // 사용자가 화면 로드를 취소하면 request 취소와 같은 상황이므로 dispose에서 cancelToken로 http request를 cancel시킴
    cancelToken.cancel();
    timer?.cancel();
  });
  ref.onCancel(() {
    print('[getProductsProvider] cancelled');
  });
  ref.onResume(() {
    print('[getProductsProvider] resumed');
    timer?.cancel()
  });
  ref.onAddListener(() {
    print('[getProductsProvider] listener added');
  });
  ref.onRemoveListener(() {
    print('[getProductsProvider] listener removed');
  });
  print('[getProductsProvider] initialized');

  // keepAlive가 get 호출 전에 실행되면 사용자가 페이지를 빠져나가도 dispose/cancel 되지 않음
  // ref.keepAlive();
  final response = await ref.watch(dioProvider).get('/products', cancelToken: cancelToken);
  // 호출 이후로 keepAlive가 호출되면 화면을 나가도 dispose되지 않고 response는 캐싱된다.
  final keepAliveLink = ref.keepAlive();

  // ref.onCancel을 keepAlive 이전에만 호출시키면 response 완료 전에 나가면 onCancel이 호출되지 않는다.
  // 그래서 데이터 호출 시점(+keepAlivie) 위치에서 위, 아래로 등록한다.
  ref.onCancel(() {
    print('[getProductsProvider] cancelled, timer started ');
    timer = Timer(const Duration(seconds: 10), () {
      keepAliveLink.close();
    });
  });

  final List productList = response.data['products'];
  final products = [for (final product in productList) Product.fromJson(product)];
  return products;
}

```

### 5. when a provider watches another provider