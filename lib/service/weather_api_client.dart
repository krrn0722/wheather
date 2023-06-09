import 'package:wheather/models/weather.dart';
import 'package:dio/dio.dart';

class WeatherApiClient {
  Future<Weather?> fetchWeather(String? location) async {
    final dio = Dio();
    const appId = '4b0e4756a7f3015c0d08c2f0263c224a&units=metric';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$appId';
    print('apiカモン');
    var response = await dio.get(url);
    print('きたよ');
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        print('いいかんじ');
        return Weather.fromJson(response.data);
      } catch (e) {
        print('以下にエラー文');
        print(e);
        throw e;
      }
    }
  }
}
