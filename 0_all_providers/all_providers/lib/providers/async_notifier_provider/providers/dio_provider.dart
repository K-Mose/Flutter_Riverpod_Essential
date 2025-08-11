import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(DioRef ref) {
  return Dio(BaseOptions(baseUrl: 'https://bored.api.lewagon.com/api/activity'))..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      print(options.uri);
      return handler.next(options);
    },
  ));
}
