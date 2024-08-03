class ChartData<K, V> {
  final Map<K, V> values;
  final V min, max;

  const ChartData(
      {this.values = const {}, required this.min, required this.max});
}
