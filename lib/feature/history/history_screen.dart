import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_test/core/constants/colors.dart';
import 'package:weather_app_test/core/models/utils/chart_data.dart';
import 'package:weather_app_test/feature/history/history_screen_controller.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key, required this.cityId});
  final int cityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(historyScreenController(cityId));
    final controller = ref.read(historyScreenController(cityId).notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: CustomColors.light,
        title: const Text('История наблюдений'),
      ),
      body: state.maybeMap(
        data: (data) {
          final flData = controller.getChartData();

          return ListView(
            children: [
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Text('Температура, °')),
              SizedBox(
                  height: 200, child: _LineChart<double>(data: flData.temp)),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Text('Влажность, %:')),
              SizedBox(
                  height: 200, child: _LineChart<int>(data: flData.humidity)),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Text('Давление, мм. рт. ст.:')),
              SizedBox(
                  height: 200, child: _LineChart<int>(data: flData.pressure))
            ],
          );
        },
        orElse: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _LineChart<V extends num> extends StatelessWidget {
  const _LineChart({super.key, required this.data});
  final ChartData<DateTime, V> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: LineChart(
        LineChartData(
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(
                y: data.max.toDouble(),
                label: HorizontalLineLabel(
                  show: true,
                  labelResolver: (p0) {
                    return 'Макс значение: ${p0.y}';
                  },
                ),
                color: CustomColors.grey,
                strokeWidth: 1,
                dashArray: [5, 4],
              ),
              HorizontalLine(
                y: data.min.toDouble(),
                color: CustomColors.grey,
                label: HorizontalLineLabel(
                  style: TextStyle(color: CustomColors.darkgrey),
                  show: true,
                  alignment: Alignment.topRight,
                  labelResolver: (p0) {
                    return 'Мин значение: ${p0.y}';
                  },
                ),
                strokeWidth: 1,
                dashArray: [5, 4],
              ),
            ],
          ),
          lineBarsData: [
            LineChartBarData(
              // isStepLineChart: true,
              spots: data.values.entries.map((e) {
                return FlSpot(e.key.millisecondsSinceEpoch.toDouble(),
                    e.value.toDouble());
              }).toList(),

              isCurved: true,
              barWidth: 4,

              color: CustomColors.lightgrey,
            ),
          ],
          minY: data.min.toDouble() - 2,
          maxY: data.max.toDouble() + 3,
          gridData: const FlGridData(
            show: false,
          ),
          titlesData: FlTitlesData(
            show: true,
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 46,
                getTitlesWidget: (value, meta) => Text(value.toString()),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  final date =
                      DateTime.fromMillisecondsSinceEpoch(value.toInt());
                  return Column(
                    children: [
                      Text(
                        DateFormat('d MMM', 'ru').format(date),
                        style: TextStyle(fontSize: 8),
                      ),
                      Text(
                        DateFormat('HH:mm', 'ru').format(date),
                        style: TextStyle(fontSize: 8),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
