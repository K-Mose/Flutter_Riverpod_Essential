import 'dart:async';

import 'package:all_providers/pagination/num_pagination/models/product.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repositories/product_repository.dart';

part 'products_providers.g.dart';

@riverpod
Future<List<Product>> getProducts(GetProductsRef ref, int page) async {
  final cancelToken = CancelToken();
  // 10초간 캐싱
  Timer? timer;

  ref.onDispose(() {
    print('[getProductsProvider] disposed');
    timer?.cancel();
  });

  ref.onCancel(() {
    print('[getProductsProvider] canceled');
  });

  ref.onResume(() {
    print('[getProductsProvider] resumed, timer canceled');
    timer?.cancel();
  });

  final products = await ref.watch(productRepositoryProvider).getProducts(page, cancelToken: cancelToken);

  final keepAliveLink = ref.keepAlive();

  ref.onCancel(() {
    print('[getProductsProvider] canceled, timer started');
    timer = Timer(const Duration(seconds: 10), () {
      keepAliveLink.close();
    });
  });

  return products;
}
