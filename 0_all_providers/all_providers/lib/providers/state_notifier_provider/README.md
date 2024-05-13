# StateNotifierProvider
`StateNotifier`의 **subclass**를 **expose**하고 **listen**할 수 있게 하는 **Provider**
**riverpod**이 `stateNotifier`를 **re-export**하여서 **StateNotifier** 패키지를 다시 **import**할 필요는 없음

복잡한 business logic을 집중화하여 핸들링하기 위해 사용

**state**를 외부에서 접근 가능하지만 변경할 수 없는 immutable state 제공
변경하기 위해서는 stateNotifier의 interface를 통해서만 변경 가능 

stateNotifierProvider보다는 NotifierProvider / AsyncNotifierProvider 사용을 추전함

code generation이 지원되지 않음