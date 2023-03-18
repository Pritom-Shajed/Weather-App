import 'dart:convert';

import 'package:http/http.dart';
import 'dart:convert';
import 'package:weather_app/models/weatherModel.dart';
import 'package:weather_app/repository/weather_repository.dart';

class WeatherController {
  final WeatherRepository weatherRepository = WeatherRepository();

  Future<WeatherModel> getWeatherCtl(double lat, double lon) async {
    WeatherModel weatherModel = WeatherModel();

    try {
      Response response = await weatherRepository.getWeatherRepo(lat, lon);

      weatherModel =
          WeatherModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } catch (error) {
      print(error.toString());
    }

    return weatherModel;
  }

  Future<WeatherModel> getWeatherCityNameCtl(String cityName) async {
    WeatherModel weatherModel = WeatherModel();

    try {
      Response response = await weatherRepository.getWeatherByCityNameRepo(cityName);

      weatherModel =
          WeatherModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } catch (error) {
      print(error.toString());
    }

    return weatherModel;
  }
}
