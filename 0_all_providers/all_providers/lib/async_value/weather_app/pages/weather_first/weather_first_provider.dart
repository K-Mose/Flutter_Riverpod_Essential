import 'package:all_providers/async_value/weather_app/models/cities.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_first_provider.g.dart';

@riverpod
class WeatherFirst extends _$WeatherFirst {
  @override
  FutureOr<String> build() async {
    return _getTemp(Cities.seoul);
  }

  Future<String> _getTemp(Cities city) async {
    await Future.delayed(const Duration(milliseconds: 800));

    switch (city) {
      case Cities.seoul:
        return "${city.name} - 23";
      case Cities.tokyo:
        return "${city.name} - 28";
      case Cities.london || Cities.bangkok:
        throw "Fail to fetch the temperature of ${city.name}";
    }
  }

  Future<void> getTemperature(Cities city) async {
    state = const AsyncLoading();
    
    state = await AsyncValue.guard(() => _getTemp(city),);
  }
}
