extension TimeFormat on DateTime {
  String get hhmm {
    return "${hour.toString().padLeft(2, '0')}:${(minute % 60).toString().padLeft(2, '0')}";
  }
}
