import 'dart:developer' as dev;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RPLogger extends ProviderObserver {
  /// Riverpod logger
  const RPLogger();
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    dev.log(
        '[${provider.name ?? provider.runtimeType}] value: ${newValue.toString()}');
  }
}
