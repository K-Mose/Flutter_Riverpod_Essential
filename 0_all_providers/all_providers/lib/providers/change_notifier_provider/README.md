# ChangeNotifierProvider 
`ChangeNotifier`는 Flutter 자체에서 제공하는 클래스
`ChangeNotifierProvider`는 `ChangeNotifier`를 **expose** 하고 **listen** 하는 **Provider**
`Provider` 패키지 내에서 가장 중요한 역할을 하는 **provider**
복잡한 business logic을 다루는데 사용됨.
`ChangeNotifierProvider`에서 제공되는 **state**는 외부에서 수정 가능
**riverpod**에서 사용을 추천 안함

**`ChangeNotifierProvider`사용 이유**
- provider -> riverpod 으로 마이그레이션 하는데 지원
- mutable state 사용하는데 지원
- ver.9 이전의 go_router 사용 시 사용

`NotifierProvider` 혹은 `AsyncNotifierProvider` 사용이 권장됨

