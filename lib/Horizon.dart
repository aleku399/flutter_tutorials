import 'package:flutter/material.dart';

class Horizon extends StatelessWidget {
    const Horizon({super.key});

    @override
    Widget build(BuildContext context) {
        return  CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.teal[500],
              pinned: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Horizons'),
                background: DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: <Color>[Colors.teal[800]!, Colors.transparent],
                    ),
                  ),
                  child: Image.network(
                    headerImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            WeatherForecast(),
          ],
        );
    }
}

class WeatherForecast extends StatelessWidget {
    const WeatherForecast({super.key});

    @override
    Widget build(BuildContext context) {
        final DateTime currentDate = DateTime.now();
        final TextTheme textTheme = Theme.of(context).textTheme;
        
        return SliverList(
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                    final DailyForecast dailyForecast = Server.getDailyForecastById(index);
                    return Card(
                        child: Row(
                            children: <Widget>[
                                SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: Stack(
                                        fit: StackFit.expand,
                                        children: <Widget>[
                                            DecoratedBox(
                                                position: DecorationPosition.foreground,
                                                decoration: BoxDecoration(
                                                    gradient: RadialGradient(
                                                        colors: <Color>[
                                                            Colors.grey[800]!,
                                                            Colors.transparent,
                                                        ],
                                                    ),
                                                ),
                                            ),
                                            Image.network(
                                                dailyForecast.imageId,
                                                fit: BoxFit.cover,
                                            ),
                                            Center(
                                                child: Text(
                                                    dailyForecast.getDate(currentDate.day).toString(),
                                                    style: textTheme.headline4,
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                                Text(
                                                    dailyForecast.getWeekday(currentDate.weekday),
                                                    style: textTheme.headline5,
                                                ),
                                                SizedBox(height: 10.0),
                                                Text(dailyForecast.description),
                                            ],
                                        ),
                                    )
                                ),
                                Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text(
                                        "${dailyForecast.highTemp} | ${dailyForecast.lowTemp} F",
                                        style: textTheme.subtitle2,
                                    ),
                                ),
                            ],        
                        ),
                    );
                },
                childCount: 7,
            ),
        ); 
    }
}

const String baseAssetURL =
    'https://dartpad-workshops-io2021.web.app/getting_started_with_slivers/';
const String headerImage = '${baseAssetURL}assets/header.jpeg';

const List<DailyForecast> weatherData = [
  DailyForecast(
    id: 0,
    imageId: '${baseAssetURL}assets/day_0.jpeg',
    highTemp: 73,
    lowTemp: 52,
    description:
        'Partly cloudy in the morning, with sun appearing in the afternoon.',
  ),
  DailyForecast(
    id: 1,
    imageId: '${baseAssetURL}assets/day_1.jpeg',
    highTemp: 70,
    lowTemp: 50,
    description: 'Partly sunny.',
  ),
  DailyForecast(
    id: 2,
    imageId: '${baseAssetURL}assets/day_2.jpeg',
    highTemp: 71,
    lowTemp: 55,
    description: 'Party cloudy.',
  ),
  DailyForecast(
    id: 3,
    imageId: '${baseAssetURL}assets/day_3.jpeg',
    highTemp: 74,
    lowTemp: 60,
    description: 'Thunderstorms in the evening.',
  ),
  DailyForecast(
    id: 4,
    imageId: '${baseAssetURL}assets/day_4.jpeg',
    highTemp: 67,
    lowTemp: 60,
    description: 'Severe thunderstorm warning.',
  ),
  DailyForecast(
    id: 5,
    imageId: '${baseAssetURL}assets/day_5.jpeg',
    highTemp: 73,
    lowTemp: 57,
    description: 'Cloudy with showers in the morning.',
  ),
  DailyForecast(
    id: 6,
    imageId: '${baseAssetURL}assets/day_6.jpeg',
    highTemp: 75,
    lowTemp: 58,
    description: 'Sun throughout the day.',
  ),
];

class Server {
    static List<DailyForecast> getDailyForecastList() =>
        weatherData; 

    static DailyForecast getDailyForecastById(int id)  {
        assert(id >= 0 && id <= 6);
        return weatherData[id];
    } 
}

class  DailyForecast {
    const DailyForecast({
        required this.id,
        required this.imageId,
        required this.highTemp,
        required this.lowTemp,
        required this.description,
    });

    final int id;
    final String imageId;
    final String description;
    final int  highTemp;
    final int lowTemp;

    static const List<String> _weekdays = <String>[
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday',
    ];

    String getWeekday(int today) {
        final offset = today + id;
        final int day = offset >=  7  ? offset - 7 : offset;
        return _weekdays[day];
    }

    int getDate(int today) {
        return today + id;
    }

}
