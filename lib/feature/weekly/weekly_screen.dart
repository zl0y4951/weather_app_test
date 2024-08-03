import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_test/core/constants/colors.dart';
import 'package:weather_app_test/core/models/weather_model.dart';
import 'package:weather_app_test/feature/home/widgets/hour_card.dart';
import 'package:weather_app_test/feature/weekly/weekly_screen_controller.dart';
import "package:collection/collection.dart";

class WeeklyScreen extends ConsumerWidget {
  const WeeklyScreen({super.key, required this.lat, required this.lon});
  final double lat, lon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(weeklyScreenController((lat, lon)));
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: CustomColors.light,
          title: const Text('Погода на неделю'),
        ),
        body: state.maybeMap(
            data: (data) {
              final groupedMap =
                  groupBy<WeatherModel, DateTime>(data.value, (el) {
                return DateTime(el.dt.year, el.dt.month, el.dt.day);
              });
              return CustomScrollView(
                slivers: groupedMap.entries.map((e) {
                  return SliverPadding(
                    padding: const EdgeInsets.only(top: 12),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Text(DateFormat('yMMMEd', 'ru').format(e.key)),
                          SizedBox(
                            height: 69,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: e.value.length,
                              itemBuilder: (context, index) {
                                return HourCard(weather: e.value[index]);
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 8),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            orElse: () => const Center(child: CircularProgressIndicator())));
  }
}
