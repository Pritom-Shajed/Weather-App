import 'package:flutter/material.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/models/weatherModel.dart';
import 'package:weather_app/repository/constrains.dart';
import 'package:weather_app/widgets/customButton.dart';
import 'package:weather_app/widgets/reusable_card.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController cityNameTextEditingCtl = TextEditingController();
  WeatherModel? weather;
  bool? emptyContainer;

  @override
  void initState() {
    super.initState();
    emptyContainer = true;
  }

  void getCurrentCity(String cityName) async {
    WeatherModel weatherModel =
        await WeatherController().getWeatherCityNameCtl(cityName);

    if (weatherModel.cod == 200) {
      setState(() {
        weather = weatherModel;
        emptyContainer = false;
        EasyLoading.showSuccess('Found your city!');
      });
    } else {
      print('error');
      setState(() {
        emptyContainer = true;
        EasyLoading.showToast('City not found!');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search'),
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
          child: Container(
              margin: EdgeInsets.all(20),
              child: ListView(
                children: [
                  Column(
                    children: [
                      TextField(
                        controller: cityNameTextEditingCtl,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          hintText: 'Enter your city',
                          hintStyle: TextStyle(color: Colors.white60),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        onPressed: () {
                          setState(() {
                            getCurrentCity(cityNameTextEditingCtl.text);
                            if (cityNameTextEditingCtl.text.isEmpty) {
                              emptyContainer = true;
                            } else {
                              emptyContainer = false;
                            }
                          });
                        },
                        buttonChild: Text('Search'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      emptyContainer == false
                          ? Container(
                              width: double.infinity,
                              child: ReusableCard(
                                cardChild: Column(
                                  children: [
                                    Text(
                                      'Weather Report',
                                      style: TextStyle(
                                          fontSize: 16,
                                          letterSpacing: 0.5,
                                          decoration: TextDecoration.underline),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Country: ',
                                                  style: greySmallTextStyle,
                                                ),
                                                Text(
                                                  '${weather?.sys?.country}',
                                                  style:
                                                  whiteSmallTextStyle,
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'City: ',
                                                  style: greySmallTextStyle,
                                                ),
                                                Text(
                                                  '${weather?.name}',
                                                  style:
                                                  whiteSmallTextStyle,
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Temp: ',
                                                  style: greySmallTextStyle,
                                                ),
                                                Text(
                                                  '${weather?.main?.temp?.toStringAsFixed(2)}℃',
                                                  style:
                                                  whiteSmallTextStyle,
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Feels Like: ',
                                                  style: greySmallTextStyle,
                                                ),
                                                Text(
                                                  '${weather?.main?.feelsLike?.toStringAsFixed(2)}℃',
                                                  style:
                                                  whiteSmallTextStyle,
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Humidity: ',
                                                  style: greySmallTextStyle,
                                                ),
                                                Text(
                                                  '${weather?.main?.humidity}%',
                                                  style:
                                                  whiteSmallTextStyle,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Image.network(
                                                'http://openweathermap.org/img/wn/${weather?.weather?[0].icon}@2x.png'),
                                            Text(
                                              '${weather?.weather?[0].main}',
                                              style: greySmallTextStyle,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              width: double.infinity,
                              child: ReusableCard(
                                cardChild: Center(
                                  child: Text(
                                    'PLEASE ENTER A VALID CITY NAME\nTO GET WEATHER REPORT',
                                    style: greySmallTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              )),
        ));
  }
}
