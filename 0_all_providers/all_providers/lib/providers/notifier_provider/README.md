# NotifierProvider
 `Notifier`를 쉽게 접근할 수 있게 해주고 `Notifier`의 state 변화를 listen 하는 Provider.
 
복잡한 **Business Logic**에 사용하는 것을 추천함

`Notifier`에서 제공하는 **interface**에서만 수정 가능한 **state**를 제공

`Notifier`의 **state**는 동기적으로 초기화됨. 비동기적으로 초기화 하려면 `AsyncNotifier` 사용

riverpod_generator를 사용해 생성 가능
  

## State Shape 
### enum based state
![img.png](img.png)
**ActivityStatus**: 현재 통신 상태를 나타낸다.
  - initial : 초기 상태.
  - loading : 데이터를 받고있는 상태, 보통 loading indicator를 표시 
  - success : 데이터 수신이 정상적으로 완료된 상태, 화면을 표시한다. 
  - failure : 데이터 수신이 비정상적으로 실패한 상태, 보통 실패 화면이나 다이얼로그를 띄운다.
**Actvity**: 데이터 수신 성공 시 현재 데이터를 표시
**error**: 데이터 수신 실패 시 에러 메시지를 표시

**Fetch Data**
```dart
  Future<void> fetchActivity(String activityType) async {
    state = state.copyWith(
      status: ActivityStatus.loading,
    );

    try {
      final response = await ref.read(dioProvider).get('?type=$activityType');
      final activity = Activity.fromJson(response.data);

      state = state.copyWith(
        status: ActivityStatus.success,
        activity: activity,
      );
    } catch (e) {
      state = state.copyWith(
        status: ActivityStatus.failure,
        error: e.toString(),
      );
    }
  }
``` 
에러가 발생했을 때 `copyWith`로 `status`와 `error`값만 변경하기 때문에 기존의 `Activity`값은 유지된다. 

### sealed class based state
  - Dart 3.0 부터 제공
<details>
<summary>freezed</summary>

![img_1.png](img_1.png)
freezed에서는 자체적으로 sealed/union class를 제공하는데, dart에서 이제 제공하므로 사용할 필요가 없음
</details>

기존의 `class A`를 만들면 해당 클래스를 extends하는 sub 클래스들을 만들 수 있다. e.g.) `class A1 extends A, class A2 extends A ...`
기존 `Flutter`에서 `state class`를 만들 때 아래와 같은 형식으로 만들었다.
```dart
abstract class ActivityState{}

class ActivityInitial extends ActivityState{}
class ActivityLoading extends ActivityState{}
class ActivitySuccess extends ActivityState{}
class ActivityFailure extends ActivityState{}
```
우리는 이러한 형태에서 ActivityState가 네트워크 통신의 모든 상황에서 처리할 수 있다는 것을 알지만, Compiler는 모든 상황을 처리할 수 있다는 것을 알 수 없다.

Dart 3.0 부터 나온 `sealed` modifier를 사용하면 SubType들의 집합을 만들 수 있다. 
`sealed class ActivityState{}`

`sealed class`가 정의된 library 외부에서 extends, implement 할 수 없다.
`sealed`는 Abstract class이기 때문에 초기화할 수 없지만 factory constructor는 가질 수 있다. 또 Subclass들 위한 constructor도 정의할 수 있다.
Compiler에서도 `sealed`의 모든 subclass들을 알 수 있다.


### AsyncValue
riverpod에 특화된 state shape



### Unhandled Exception: Tried to modify a provider while the widget tree was building.
아래 리스트에서 provider를 modifier하려 해서 발생
**in a widget life-cycle, such as but not limited to:**
- build
- initState
- dispose
- didUpdateWidget
- didChangeDependencies
      
Modifying a provider inside those life-cycles is not allowed, as it could
lead to an inconsistent UI state. For example, two widgets could listen to the
same provider, but incorrectly receive different states.
-> 일관성 없는 UI 상태를 야기할 수 있음
                                
**해결법** 
  To fix this problem, you have one of two solutions:
  - (preferred) Move the logic for modifying your provider outside of a widget
    life-cycle. For example, maybe you could update your provider inside a button's
    onPressed instead.
  **-> provider를 lifecycle 밖에서 호출 시켜라**
  - Delay your modification, such as by encapsulating the modification
    in a `Future(() {...})`.
    This will perform your update after the widget tree is done building.
  **-> `Future`같은 것으로 감싸서 widget의 building이 완성된 후에 호출시켜라**

 
아래 코드 둘 중 하나 사용
```dart
    Future.delayed(Duration.zero, () {
      
    });
// or
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      
    });

```