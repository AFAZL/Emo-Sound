import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminPage extends StatefulWidget {
  final String email;

  AdminPage({required this.email});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String selectedYear = '2022';

  Map<String, Map<String, double>> userDataByYear = {
    '2022': {
      'January': 10,
      'February': 20,
      'March': 30,
      'April': 25,
      'May': 35,
      'June': 30,
      'July': 40,
      'August': 45,
      'September': 20,
      'October': 40,
      'November': 30,
      'December': 20,
    },
    '2023': {
      'January': 15,
      'February': 25,
      'March': 35,
      'April': 30,
      'May': 40,
      'June': 35,
      'July': 45,
      'August': 50,
      'September': 55,
      'October': 45,
      'November': 35,
      'December': 25,
    },
    '2024': {
      'January': 20,
      'February': 30,
      'March': 40,
      'April': 35,
      'May': 45,
      'June': 40,
      'July': 50,
      'August': 55,
      'September': 30,
      'October': 50,
      'November': 40,
      'December': 30,
    },
  };

  Map<String, double> getUserDataForYear(String year) {
    return userDataByYear[year]!;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> userDataMap = getUserDataForYear(selectedYear);

    Map<String, double> genderDataMap = {
      'Male': 40,
      'Female': 40,
      'Other': 10,
    };

    Map<String, double> emotionDataMap = {
      'Angry': 20,
      'Sad': 15,
      'Happy': 35,
      'Surprise': 15,
      'Fear': 15,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white, // Set background color to white
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: Text('User Action'),
                onTap: () {
                  Navigator.pushNamed(context, '/UserAction');
                },
              ),
              ListTile(
                title: Text('Music Action'),
                onTap: () {
                  Navigator.pushNamed(context, '/MusicAction');
                },
              ),
              // Add more ListTile widgets for additional items
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.width / 2.5,
                        child: PieChart(
                          PieChartData(
                            sections: genderDataMap.entries.map((entry) {
                              return PieChartSectionData(
                                color: _getColor(entry.key),
                                value: entry.value,
                                title: '${entry.key} (${entry.value}%)',
                                titleStyle: TextStyle(color: Colors.black),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Gender Distribution',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.width / 2.5,
                        child: PieChart(
                          PieChartData(
                            sections: emotionDataMap.entries.map((entry) {
                              return PieChartSectionData(
                                color: _getColor(entry.key),
                                value: entry.value,
                                title: '${entry.key} (${entry.value}%)',
                                titleStyle: TextStyle(color: Colors.black),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Emotion Distribution',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'User vs Month for $selectedYear',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 20),
                DropdownButton<String>(
                  value: selectedYear,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedYear = newValue!;
                      userDataMap = getUserDataForYear(selectedYear);
                    });
                  },
                  items: <String>['2022', '2023', '2024']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              padding: EdgeInsets.all(16),
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 11,
                  minY: 0,
                  maxY: 70,
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(showTitles: true, reservedSize: 40),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (value) {
                        switch (value.toInt()) {
                          case 0:
                            return 'Jan';
                          case 1:
                            return 'Feb';
                          case 2:
                            return 'Mar';
                          case 3:
                            return 'Apr';
                          case 4:
                            return 'May';
                          case 5:
                            return 'Jun';
                          case 6:
                            return 'Jul';
                          case 7:
                            return 'Aug';
                          case 8:
                            return 'Sep';
                          case 9:
                            return 'Oct';
                          case 10:
                            return 'Nov';
                          case 11:
                            return 'Dec';
                          default:
                            return '';
                        }
                      },
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: userDataMap.entries
                          .map((entry) => FlSpot(
                              userDataMap.keys.toList().indexOf(entry.key).toDouble(), entry.value))
                          .toList(),
                      isCurved: true,
                      colors: [Colors.blue],
                      barWidth: 4,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor(String key) {
    switch (key) {
      case 'Male':
        return Colors.blue;
      case 'Female':
        return Colors.pink;
      case 'Other':
        return Colors.orange;
      case 'Angry':
        return Colors.red;
      case 'Sad':
        return Colors.blue;
      case 'Happy':
        return Colors.green;
      case 'Surprise':
        return Colors.orange;
      case 'Fear':
        return Colors.yellow;
      default:
        return Colors.black;
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: AdminPage(email: "example@example.com"),
  ));
}
