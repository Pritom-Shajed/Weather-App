import 'package:http/http.dart';

class WeatherRepository {
  Future<Response> getWeatherRepo(double lat, double lon) async {
    Response response = await Client().get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=810b9c67d42abcf04f283810b5b72bb6&units=metric'),
    );

    return response;
  }

  Future<Response> getWeatherByCityNameRepo(String cityName) async {
    Response response = await Client().get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=810b9c67d42abcf04f283810b5b72bb6&units=metric'),
    );

    return response;
  }
}
