import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value, ProviderContainer container) {
    print('''
{
  "provider" : ${provider.name ?? provider.runtimeType} is initialized",
  "value exposed" : "$value"
}
''');
  }

  @override
  void didDisposeProvider(ProviderBase<Object?> provider, ProviderContainer container) {
    print(''''
{
  "provider" : ${provider.name ?? provider.runtimeType} is disposed",
}
    ''');
  }

  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue, Object? newValue, ProviderContainer container) {
    print('''
{
  "provider" : ${provider.name ?? provider.runtimeType} is updated",
  "previous value" : "$previousValue"
  "new value" : "$newValue" 
}    
    ''');
  }
}
