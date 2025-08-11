# AsyncNotifierProvider
`NotifierProvider`가 `Notifier`의 변화를 감지하는 것 처럼 `AsyncNotifierProvider`는 `AsyncNotifier`의 변화를 감지하고 노출하는데 사용되는 `Provider`

riverpod에서 복잡한 business logic을 다루어야할 경우 Notifier, AsyncNotifier 사용을 권장한다. 

`AsyncNotifierProvider`는 외부에서 state를 읽을 수는 있지만 변경할 수는 없는 immutable한 state를 제공한다. 

state를 변경하기 위해서는 `AsyncNotifier`에서 제공되는 인터페이스를 통해서만 데이터 변경이 가능하다. 

`AsyncNotifierProvider`가 `NotifierProvider`와 다른 점은 비동기적으로 초기화되는 `Notifier`라고 볼 수 있다.

![image](./img.png)
`AsyncNotifierProvider`에서는 `AsyncValue`값을 사용하여 상태를 관리하고, sealed class와 enum의 특성을 합친 것과 비슷하다. 


## [AsyncValue](https://pub.dev/documentation/riverpod/latest/riverpod/AsyncValue-class.html)
`AsyncValue`는 비동기 작업에서 loading/error 상황을 잊지않고 처리하기 위해 사용한다.

### AsysncDaya의 상태
<details><summary>logs</summary>

```
// 1번째 실행, 에러 발생
I/flutter ( 5756): AsyncLoading<Activity>()
I/flutter ( 5756): isLoading: true, isRefreshing: false, isReloading: false 
I/flutter ( 5756): hasValue: false, hasError: false

I/flutter ( 5756): AsyncError<Activity>(error: Fail to fetch Activity)
I/flutter ( 5756): isLoading: false, isRefreshing: false, isReloading: false 
I/flutter ( 5756): hasValue: false, hasError: true

// 2번째 실행, 정상 동작
// asyncLoading 상태에서 error가 보존된다. 
I/flutter ( 5756): AsyncLoading<Activity>(error: Fail to fetch Activity)
I/flutter ( 5756): isLoading: true, isRefreshing: false, isReloading: true 
I/flutter ( 5756): hasValue: false, hasError: true
I/flutter ( 5756): https://bored.api.lewagon.com/api/activity?type=diy
// asyncData에서 error가 사라짐  
I/flutter ( 5756): AsyncData<Activity>(value: Activity(activity: Find a DIY to do, accessibility: 0.3, type: diy, participants: 1, price: 0.4, key: 4981819))
I/flutter ( 5756): isLoading: false, isRefreshing: false, isReloading: false 
I/flutter ( 5756): hasValue: true, hasError: false
```

</details>
- AsyncLoading : `AsyncValue`의 `value`와 `error` 값을 유지한다.  
- AsyncError : `AsyncValue`의 `value`는 유지하고, `error`값을 업데이트한다.
- AsyncData :  `AsyncValue`의 `value`값을 업데이트하고, `error`값을 초기화 시킨다.

### Build에서의 FutureOr와 Future
**50번 강의 질문 참고**
1. return 값이 **int** (T) 타입
```
@override
FutureOr<int> build(int initialValue) {
  ref.onDispose(() {
    print('[counterProvider] disposed');
  });
  return initialValue;
}
```
반환하는 값이 제네릭 타입일 경우에는 `AsyncValue`에서 `AsyncLoading` 없이 `AsyncData`가 바로 실행된다.   
2. return 값이 **Future\<int\>** 타입
```
@override
FutureOr<int> build(int initialValue) {
  ref.onDispose(() {
    print('[counterProvider] disposed');
  });
  return Future.value(initialValue);
}
```
반환하는 값이 **Future\<T\>** 일 경우에는 `AsyncLoading` 동안 Futuer의 비동기 작업이 처리되며 `AsyncData`(또는 `AsyncError`)가 실행된다.

### [when](https://pub.dev/documentation/riverpod/latest/riverpod/AsyncValueX/when.html)

```dart
R when<R>({
  bool skipLoadingOnReload = false,
  bool skipLoadingOnRefresh = true,
  bool skipError = false,
  required R data( T data ),
  required R error( Object error, StackTrace stackTrace ),
  required R loading(),
})
```
`when`은 `AsyncValue`의 확장 함수로 `AsyncValue`가 `data`, `error`, `loading` 상태일 때 표시할 위젯을 나타내도록 한다. 
<br><br>
`error`의 stackTrance를 직접 전달할 수 없을 때는 `StackTrace.current`를 전달하면 된다. 
<br><br>
`skipLoadingOnRefresh`를 `true`로 주면 `provider`를 `invalidate` 했을 때 로딩 화면을 표시할 수 있다.<br><br>
`skipError`를 `true`로 설정하면 previous value가 있을 시 에러 화면을 보여주지 않고 previous 데이터를 화면에 보여준다. 이러면 Dialog나 SnackBar 같은 위젯으로 오류를 보여주면서 화면은 유지할 수 있다.<br><br>
`skipLoadingOnReload`를 `true`로 설정하면 previous value나 error가 있을 시 로딩 화면을 보여주지 않고 데이터 화면만 보여준다. 비동기적으로 데이터를 처리하는 것 처럼 보여줄 때 유용할 것 같다.

### [guard](https://pub.dev/documentation/riverpod/latest/riverpod/AsyncValue/guard.html)
```dart
static Future<AsyncValue<T>> guard<T>(
  Future<T> Function() future, [
  bool Function(Object)? test,
]) async {
  try {
    return AsyncValue.data(await future());
  } catch (err, stack) {
    if (test == null) {
      return AsyncValue.error(err, stack);
    }
    if (test(err)) {
      return AsyncValue.error(err, stack);
    }

    Error.throwWithStackTrace(err, stack);
  }
}
```
`guard`는 `Future`의 결과를 통해서 결과가 성공이면 `AsyncData`에 실패면 `AsyncError`에 데이터를 넣고 반환한다. 

기존 아래와 같이 try-catch의 boilerplate code를 줄일 수 있다.
```dart
/// guard 적용 전
Future<void> increment() async {
  state = const AsyncLoading();

  try {
    await waitSecond();
    state = AsyncData(state.value! + 1);
  } catch (error, stackTrace) {
    state = AsyncError(error, stackTrace);
  }
}

Future<void> decrement() async {
  state = const AsyncLoading();
  
  try {
    await waitSecond();
    state = AsyncData(state.value! - 1);
  } catch (error, stackTrace) {
    state = AsyncError(error, stackTrace);
  }
}

/// guard 적용 후
Future<void> increment() async {
  state = const AsyncLoading();

  state = await AsyncValue.guard(() async {
    await waitSecond();
    return state.value! + 1;
  },);
}

Future<void> decrement() async {
  state = const AsyncLoading();

  state = await AsyncValue.guard(() async {
    await waitSecond();
    return state.value! - 1;
  },);
}
```

### modifier 적용
`AsyncNotifierProvider`에서 autoDispose, family modifier의 사용은 아래와 같다 

**autoDispose** 
```dart
// AsyncNotifier대신 AutoDisposeAsyncNotifier이 사용된다.
class Counter extends AutoDisposeAsyncNotifier<int> {
//  ...
}
// autoDispose modifier만 추가하면 된다. 
final counterProvider = AsyncNotifierProvider.autoDispose<Counter, int>(Counter.new);
```

**famiily** 
```dart
// AsyncNotifier대신 FamilyAsyncNotifier이 사용되고
// 초기값으로 사용될 타입 입력이 필요하다. 
class Counter extends FamilyAsyncNotifier<int, int> {
  // build 함수에 초기값이 필요하며 param 이름은 arg이 권장된다.
  @override
  FutureOr<int> build(int arg) async {
    // ...
    return arg;
  }
}
final counterProvider = AsyncNotifierProvider.autoDispose<Counter, int>(Counter.new);
```
**autoDispose & family** 
```dart
// AutoDisposeFamilyAsyncNotifier를 사용하고 family와 같이 초기값 타입을 받는다. 
class Counter extends AutoDisposeFamilyAsyncNotifier<int, int> {
  @override
  FutureOr<int> build(int arg) async {
    // ...
    return arg;
  }  
}
final counterProvider = AsyncNotifierProvider.autoDispose.family<Counter, int, int>(Counter.new);
```