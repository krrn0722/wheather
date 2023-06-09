import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wheather/Repository/repository.dart';
import 'package:wheather/models/weather.dart';

final cityNameProvider = StateProvider((ref) => 'Tokyo');

final repostitoryProvider = Provider((ref) => Repository());

// APIの取得
final dataProvider = FutureProvider.autoDispose<Weather>((ref) async {
  final repository = ref.read(repostitoryProvider);
  final cityName = ref.watch(cityNameProvider.notifier);
  // 都市名を組み込み、APIを取得する
  return await repository.fetchWeather(cityName.state);
});
