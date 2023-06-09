import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wheather/Repository/repository.dart';
import 'package:wheather/config/config.dart';
import 'package:wheather/conponent/button_widget.dart';
import 'package:wheather/view_model/providers.dart';

class InputPage extends ConsumerWidget {
  InputPage({super.key});
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityName = ref.watch(cityNameProvider.notifier);
    return KeyboardDismissOnTap(
        child: Scaffold(
            body: Center(
      child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              const Text('Clima', style: kTitleTextStyle),
              const SizedBox(height: 20.0),
              Image.asset(
                'assets/icon.png',
                width: 160,
                height: 160,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: controller,
                  onChanged: (value) {
                    cityName.state = value;
                  },
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '都市名を入力してください',
                    hintStyle: kTextFieldLabelStyle,
                    labelText: 'CityName',
                    labelStyle: kTextFieldLabelStyle,
                    fillColor: Colors.white,
                    filled: true,
                    focusedBorder: kTextFieldStyle,
                    enabledBorder: kTextFieldStyle,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ButtonWidget(
                  label: '検索',
                  press: () {
                    Repository repository = Repository();
                    repository.fetchWeather(cityName.state);
                    Navigator.pushNamed(context, '/result');
                  })
            ],
          )),
    )));
  }
}
