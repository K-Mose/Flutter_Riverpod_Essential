# NotifierProvider
 `Notifier`를 쉽게 접근할 수 있게 해주고 `Notifier`의 state 변화를 listen 하는 Provider.
 
복잡한 **Business Logic**에 사용하는 것을 추천함

`Notifier`에서 제공하는 **interface**에서만 수정 가능한 **state**를 제공

`Notifier`의 **state**는 동기적으로 초기화됨. 비동기적으로 초기화 하려면 `AsyncNotifier` 사용

riverpod_generator를 사용해 생성 가능
  