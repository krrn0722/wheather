import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wheather/config/config.dart';
import 'package:wheather/conponent/button_widget.dart';
import 'package:wheather/conponent/info_text.dart';
import 'package:wheather/view_model/providers.dart';

class ResultPage extends ConsumerWidget {
  const ResultPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncWeatherValue = ref.watch(dataProvider);
    final cityName = ref.watch(cityNameProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Clima')),
      body: Center(
        child: asyncWeatherValue.when(
            data: (data) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: kCityNameContainerStyle,
                      child: Text(cityName.state, style: kCityNameTextStyle),
                    ),
                    const SizedBox(height: 60.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InfoText(
                            label: '気温',
                            value: data.main!.temp.toString() + '°'),
                        InfoText(
                          label: '体感気温',
                          value: data.main!.feels_like.toString() + '°',
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InfoText(
                          label: '湿度',
                          value: data.main!.humidity.toString() + '%',
                        ),
                        InfoText(
                          label: '気圧',
                          value: data.main!.pressure.toString() + 'hPa',
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    ButtonWidget(
                      label: '更新',
                      press: () async {
                        ref.refresh(dataProvider);
                      },
                    ),
                  ]);
            },
            error: (e, stack) => Text(e.toString()),
            loading: () => const CircularProgressIndicator()),
      ),
    );
  }
}
