import 'dart:async';

import 'package:all_providers/provider_lifecycle/models/product.dart';
import 'package:all_providers/providers/async_notifier_provider/providers/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
Dio dio(DioRef ref) {
  return Dio(
    BaseOptions(baseUrl: 'https://dummyjson.com')
  );
}

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
    timer?.cancel();
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

@riverpod
FutureOr<Product> getProduct(GetProductRef ref, {required int productId}) async {
  ref.onDispose(() {
    print('[getProductsProvider] disposed');
  });
  ref.onCancel(() {
    print('[getProductsProvider] cancelled');
  });
  ref.onResume(() {
    print('[getProductsProvider] resumed');
  });
  ref.onAddListener(() {
    print('[getProductsProvider] listener added');
  });
  ref.onRemoveListener(() {
    print('[getProductsProvider] listener removed');
  });
  print('[getProductsProvider] initialized');
  final response = await ref.watch(dioProvider).get('/products/$productId');
  
  final product = Product.fromJson(response.data);
  return product;
}