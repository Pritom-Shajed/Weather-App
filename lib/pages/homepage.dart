import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/models/weatherModel.dart';
import 'package:weather_app/pages/searchPage.dart';
import 'package:weather_app/repository/constrains.dart';
import 'package:weather_app/widgets/customButton.dart';
import 'package:weather_app/widgets/reusable_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  WeatherModel? weather;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getLatLon();
  }

  void getLatLon() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      getCurrentLocation(position.latitude, position.longitude);
      print(position.latitude);
      print(position.longitude);
    } catch (error) {
      print(error.toString());
    }
  }

  void getCurrentLocation(double lat, double lon) async {
    WeatherModel weatherModel =
        await WeatherController().getWeatherCtl(lat, lon);

    if (weatherModel.cod == 200) {
      setState(() {
        weather = weatherModel;
        isLoading = false;
      });
    } else {
      print('error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        backgroundColor: Colors.black38,
        centerTitle: true,
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: isLoading == false
              ? Container(
                  padding: EdgeInsets.only(top: 20),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Text(
                            '${weather?.sys?.country?.toString()}, ${weather?.name.toString()}',
                            style: mediumTextStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${weather?.main?.temp?.toStringAsFixed(2)}℃',
                            style: largeTextStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${weather?.weather?[0].main}',
                            style: greySmallTextStyle,
                          ),
                          Image.network(
                            'http://openweathermap.org/img/wn/${weather?.weather?[0].icon}@4x.png', color: Colors.white,
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: ReusableCard(
                                  cardChild: Column(
                                    children: [
                                      Text(
                                        'Temperature',
                                        style: greySmallTextStyle,
                                      ),
                                      Text(
                                        '${weather?.main?.temp?.toStringAsFixed(2)}℃',
                                        style: whiteSmallTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ReusableCard(
                                  cardChild: Column(
                                    children: [
                                      Text(
                                        'Feels Like',
                                        style: greySmallTextStyle,
                                      ),
                                      Text(
                                        '${weather?.main?.feelsLike?.toStringAsFixed(2)}℃',
                                        style: whiteSmallTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ReusableCard(
                                  cardChild: Column(
                                    children: [
                                      Text(
                                        'Wind',
                                        style: greySmallTextStyle,
                                      ),
                                      Text(
                                        '${weather?.wind?.speed?.toStringAsFixed(2)} m/sec',
                                        style: whiteSmallTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ReusableCard(
                                  cardChild: Column(
                                    children: [
                                      Text(
                                        'Humidity',
                                        style: greySmallTextStyle,
                                      ),
                                      Text(
                                        '${weather?.main?.humidity}%',
                                        style: whiteSmallTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SearchPage();
                              }));
                            },
                            buttonChild: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Search by city... '),
                                Icon(
                                  Icons.location_city_rounded,
                                  size: 12,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ))
              : Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
