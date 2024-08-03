import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app_test/core/constants/colors.dart';
import 'package:weather_app_test/core/models/daily_weather_model.dart';
import 'package:weather_app_test/core/models/search/coordinates.dart';
import 'package:weather_app_test/core/models/search/geo_city.dart';
import 'package:weather_app_test/feature/home/home_screen_controller.dart';
import 'package:weather_app_test/feature/home/widgets/hour_card.dart';
import 'package:weather_app_test/feature/home/widgets/search_widget.dart';
import 'package:weather_app_test/feature/home/widgets/sun_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeScreenController);
    final controller = ref.read(homeScreenController.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 44),
                child: Row(
                  children: [
                    Flexible(
                      child: SearchWidget<GeoCity>(
                        search: controller.search,
                        onChanged: (result) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: CustomColors.light,
                                title: const Text('Основной город'),
                                content: const Text(
                                    'Использовать выбранный город в качестве основного?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Нет'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      controller.choose(result.value);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Да'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      controller.choose(result.value, true);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.explore,
                        color: CustomColors.darkgrey,
                      ),
                      onPressed: () {
                        context.go('/history/${state.value?.city.id}');
                      },
                    ),
                  ],
                )),
            ...state.maybeMap(data: (data) {
              final DailyWeatherModel value = data.value;
              return [
                Icon(
                  value.weather.icon,
                  size: 120,
                ),
                Center(
                  child: Text(
                    value.city.name,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                Center(
                  child: Text(
                    '${value.weather.temp}°',
                    style: const TextStyle(fontSize: 55),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 69,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return HourCard(weather: value.daily[index]);
                    },
                    itemCount: value.daily.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 8);
                    },
                  ),
                ),
                if (value.city.sunrise != null && value.city.sunset != null)
                  SunCard(
                    sunrise: value.city.sunrise!,
                    sunset: value.city.sunset!,
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: CustomColors.light,
                        foregroundColor: CustomColors.darkgrey,
                        side: BorderSide.none,
                      ),
                      onPressed: () {
                        final coords = Coords.fromJson(value.city.coords);
                        context
                            .go('/weekly?lat=${coords.lat}&lon=${coords.lon}');
                      },
                      child: const Text('Посмотреть полную неделю')),
                )
              ];
            }, orElse: () {
              return const [Center(child: CircularProgressIndicator())];
            })
          ],
        ),
      ),
    );
  }
}
