# StreamProvider
`Stream`을 **expose**하고 **listen**할 수 있게 하는 `Provider`
**Stream**은 연속되는 **Future**의 집합이라 할 수 있어 `AsyncValue`를 사용함

마지막으로 emit된 데이터를 캐싱하고 있음 

`StreamProvider`는 첫 상태는 `AsyncLoading`이고 그 다음부터 결과에 따라 `AsyncData`/`AsyncError`가 연속적으로 반복된다.