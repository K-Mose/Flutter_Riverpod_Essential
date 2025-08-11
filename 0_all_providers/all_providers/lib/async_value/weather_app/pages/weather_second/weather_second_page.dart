import 'package:all_providers/async_value/weather_app/models/cities.dart';
import 'package:all_providers/async_value/weather_app/pages/weather_second/weather_second_provider.dart';
import 'package:all_providers/providers/async_notifier_provider/extensions/async_vlaue_xx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

int _selectedCityIndex = 1;

class WeatherSecondPage extends ConsumerWidget {
  const WeatherSecondPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<String>>(weatherSecondProvider, (previous, next) {
      if (next.hasError && !next.isLoading) {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            content: Text(next.error.toString()),
          );
        },);
      }
    },);

    final weather = ref.watch(weatherSecondProvider);

    print(weather.toString());
    print(weather.props);

    print("value :: ${weather.value}");
    print("valueOrNull :: ${weather.valueOrNull}");

    try {
      print('requiredValue: ${weather.requireValue}');
    } on StateError {
      print('StateError');
    } catch (e) {
      print(e.toString());
    }

    print(" ================================================ ");

    return Scaffold(
      appBar: AppBar(
        title: const Text('AsyncValue Details - Second'),
        actions: [
          IconButton(
            onPressed: () {
              _selectedCityIndex = 1;
              // cityProvider를 waetherProvider가 Watch 하고 있으므로 invalidate 되면 연쇄적으로 disposed 됐다가 initialized 됨
              ref.invalidate(cityProvider);
              // weatherSecondProvider만 invalidate 하면 weather만 rebuild 되고
              // 둘 다 invalidate 하면 city invalidate, weather invalidate, city initialize, weather initialize 됨
              ref.invalidate(weatherSecondProvider);
              // 의존관계가 복잡 할 수록 invalidate 할 때 원하는 시나리오대로 나오기 어려워 질 수 있다.
              // 앱의 로직을 정확히 파악한 후에 설계하는 것이 중요하다.
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Center(
        child: weather.when(
          skipError: true,
          skipLoadingOnRefresh: false,
          data: (temp) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  temp,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 20,),
                const GetWeatherButton(),
              ],
            );
          },
          error: (e, st) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  e.toString(),
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20,),
                const GetWeatherButton(),
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class GetWeatherButton extends ConsumerWidget {
  const GetWeatherButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      onPressed: () {
        final cityIndex = _selectedCityIndex % 4;
        final city = Cities.values[cityIndex];

        _selectedCityIndex++;
        ref.read(cityProvider.notifier).changeCity(city);
      },
      child: const Text('Get Weather'),
    );
  }
}
