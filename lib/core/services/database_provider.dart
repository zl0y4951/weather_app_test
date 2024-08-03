import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_test/core/db/database.dart';

final databaseProvider = Provider<Database>(
  (ref) => Database(),
);
