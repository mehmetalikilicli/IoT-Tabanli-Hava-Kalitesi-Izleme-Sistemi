import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class Deneme1 extends StatefulWidget {
  Deneme1({Key key}) : super(key: key);

  @override
  _Deneme1State createState() => _Deneme1State();
}

class ClicksPerYear {
  final String year;
  int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);

  incrementClick() {
    clicks++;
  }
}

class _Deneme1State extends State<Deneme1> {
  var currentTime = DateFormat('dd/MM/yyyy').format(DateTime.now());
  Map<String, ClicksPerYear> data;

  @override
  void initState() {
    data = {
      '2015': ClicksPerYear('2015', 3, Colors.red),
      '2016': ClicksPerYear('2016', 7, Colors.orange),
      '2017': ClicksPerYear('2017', 42, Colors.yellow),
      '$currentTime': ClicksPerYear('$currentTime', 0, Colors.green),
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var series = [
      new charts.Series(
          domainFn: (ClicksPerYear clickData, _) => clickData.year,
          measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
          colorFn: (ClicksPerYear clickData, _) => clickData.color,
          id: 'Clicks',
          data: data.values.toList()),
    ];
    var chart = new charts.BarChart(
      series,
      animate: true,
    );

    var chartWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

    return new Scaffold(
      appBar: new AppBar(),
      body: new Center(child: chartWidget),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  data.putIfAbsent(
                      '2012', () => ClicksPerYear('2012', 42, Colors.teal));
                });
              },
              child: Icon(
                Icons.add,
              ),
              backgroundColor: Colors.red,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  DateTime now = DateTime.now();
                  currentTime = DateFormat('dd/MM/yyyy').format(now);
                  data[currentTime].incrementClick();
                });
              },
              child: Icon(
                Icons.add,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
