# AsyncValue Details


### Property 
- **value** <br>
![img.png](img.png) <br>
각 상태별 `previous value`의 유무에 따른 `value` 값을 나타낸다.
`AsyncValue`가 한번이라도 `value`를 갖게되면 null이나 error를 발생시키지 않는다.


- **error, stackTrace** <br>
![img_1.png](img_1.png) <br>
  각 상태별 `previous error`의 유무에 따른 `error` 값을 나타낸다.
`AsyncLoading`일 때는 이전 에러가 존재할 때만 `error`를 갖는다.
`AsyncData`일 때는 데이터를 성공적으로 가져왔기 때문에 `error`를 가지고있을 필요가 없다.
`AsyncError`일 때는 항상 에러 값을 가지고 있는다.

  
- **isLoading, hasValue, hasError** <br>
![img_2.png](img_2.png) <br>
`isLoading`, `hasValue`는 `AsyncValue`의 Property이고, `hasError`는 `AsyncValueX`의 Property이다.
  - `isLoading`은 현재 값이 비동기적으로 값을 가져오고 있으면 **true**를 갖는다.
  - `hasValue`는 `value` Property가 값을 가지고 있으면 **true**를 갖는다. 현재 로딩 상태이거나 에러 상태여도 이전에 가져온 데이터가 있으면 **true**이다.
  - `hasError`는 `error` Property가 null이 아니면 **true**이다. 데이터를 가져오고 있어도 이전에 에러가 발생했으면 **true**이다. (`AsyncData`상태가 되면 `error`가 null이 되므로 **false**가 된다.)
상태와 다르게 위 세 값은 모두 true일 수 있다. 

<br><br>
**isReloading**
```dart
bool get isReloading => (hasValue || hasError) && this is AsyncLoading;
```
`isReloading`은 hasValue나 hasError가 true이며 AsyncLoading 상태여야 한다. 즉, 처음 데이터를 불러올 때는 `isLoading`은 true지만 `isReloading`은 false이다. 
<br><br>
e.g.) `FutureProvider`가 `ref.watch`를 통해서 다른 Provider를 watch하는 경우. `FutureProvider`가 의존하는 provider의 state가 변하게되면 `FutureProvider`가 rebuild 되면서 값을 다시 요청하게된다. <br>
Provider가 rebuild 되는 경우는 `ref.refresh`나 `ref.invalidate`되는 경우에 발생하게 된다. 이때는 provider가 dispose되었다가 rebuild 되므로 `isReloading`은 **false**가 되고 `isRefreshing`이 **true**가 된다.
<br><br>
**isRefreshing**
```dart
bool get isRefreshing =>
    isLoading && (hasValue || hasError) && this is! AsyncLoading;
```
한 provider가 의존하는 다른 provider가 변하지 않았어도 `ref.refresh`나 `ref.invalidate`가 호출되면서 provider가 강제로 rebuild 될 때 true가 된다. <br>
단, 한 번이라도 데이터를 불러온 후에 true가 된다. (`hasValue || hasError`)
<br><br>
**valurOrNull**
```dart
T? get valueOrNull {
  if (hasValue) return value;
  return null;
}
```
state가 값을 가지고 있으면 해당 값을 반환한다. `AsyncData`에서는 무조건 value를 반환하고, `AsyncLoading`이나 `AsyncError`일 때는 previous value가 없으면 null을 반환한다.
<br><br>
**requireValue**
```dart
T get requireValue {
  if (hasValue) return value as T;
  if (hasError) {
    throwErrorWithCombinedStackTrace(error!, stackTrace!);
  }

  throw StateError(
    'Tried to call `requireValue` on an `AsyncValue` that has no value: $this',
  );
}
```
`requireValue`는 UI에서 `AsyncValue`값이 null이 아닐 때만 안전하게 사용 가능하다. `hasError` 상태에서는 현재 에러를 rethrow하고 이외에는 `StateError`를 발생시킨다.

### [ref.refresh vs ref.invalidate](https://riverpod.dev/docs/essentials/faq)
