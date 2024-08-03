import 'dart:async';

class Debouncer<T> {
  final Duration duration;
  Timer? _timer;
  Completer<T> completer = Completer<T>();

  /// Класс откладывающий выполнение [run] до [duration]
  ///
  /// Так же возвращает [future], который решится после [run]
  Debouncer({
    this.duration = const Duration(milliseconds: 500),
  });
  Future<T> run(FutureOr<T> Function() action) {
    if (_timer != null) {
      _timer?.cancel();
      completer = Completer<T>();
    }
    _timer = Timer(duration, () async {
      final result = await action();
      completer.complete(result);
    });
    return completer.future;
  }
}
