import 'dart:convert';
import 'package:dhtdata/charts/nemchart.dart';
import 'package:dhtdata/charts/ppmchart.dart';
import 'package:dhtdata/charts/sensorvoltagechart.dart';
import 'package:dhtdata/charts/sicaklikchart.dart';
import 'package:dhtdata/charts/yanicigazchart.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Nesnelerin Interneti',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: Chart(),
      home: MyHomePage(0.0, 0, 0, 0, 0, title: 'Hava Kirliligi'),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage(
      this.ppm, this.sicaklik, this.nem, this.yaniciGaz, this.sensorVoltage,
      {Key key, this.title})
      : super(key: key);
  String title;
  double ppm;
  double sicaklik;
  double nem;
  double yaniciGaz;
  double sensorVoltage;
  List<PpmData> ppmData = [];
  List<SicaklikData> sicaklikData = [];
  List<NemData> nemData = [];
  List<YaniciGazData> yaniciGazData = [];
  List<SensorVoltageData> sensorVoltageData = [];
  double i = 0;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _getDht() async {
    var url = Uri.parse(
        "https://api.thingspeak.com/channels/1588787/feeds.json?api_key=GKEQ7ZDQH706TVGZ&results=1");

    while (true) {
      var result = await http.get(url);
      Map<String, dynamic> feeds = jsonDecode(result.body);
      Map<String, dynamic> fields = feeds["feeds"][0];

      setState(() {
        widget.ppm = double.parse(fields["field1"]);
        widget.ppmData.add(PpmData(widget.ppm, widget.i));
        widget.i++;
      });
      print("---------" + widget.i.toString() + "--------------");
      print("ppm : -> " + widget.ppm.toString());

      setState(() {
        widget.sicaklik = double.parse(fields["field2"]);
        widget.sicaklikData.add(SicaklikData(widget.sicaklik, widget.i));
      });
      print("sicaklik : -> " + widget.sicaklik.toString());

      setState(() {
        widget.nem = double.parse(fields["field3"]);
        widget.nemData.add(NemData(widget.nem, widget.i));
      });
      print("nem : -> " + widget.nem.toString());

      setState(() {
        widget.yaniciGaz = double.parse(fields["field4"]);
        widget.yaniciGazData.add(YaniciGazData(widget.yaniciGaz, widget.i));
      });
      print("yanici Gaz : -> " + widget.yaniciGaz.toString());

      setState(() {
        widget.sensorVoltage = double.parse(fields["field5"]);
        widget.sensorVoltageData
            .add(SensorVoltageData(widget.sensorVoltage, widget.i));
      });
      print("Sensor Voltaji : -> " + widget.sensorVoltage.toString());

      //sleep(Duration(seconds: 5));
    }
  }

  @override
  void initState() {
    super.initState();

    _getDht();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: new Container(
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                            minimum: 0.0,
                            maximum: 10000.0,
                            ranges: <GaugeRange>[
                              GaugeRange(
                                  startValue: 0.0,
                                  endValue: 5000.0,
                                  color: Colors.blue),
                              GaugeRange(
                                  startValue: 5000.0,
                                  endValue: 7000.0,
                                  color: Colors.orange),
                              GaugeRange(
                                  startValue: 7000.0,
                                  endValue: 10000,
                                  color: Colors.red)
                            ],
                            pointers: <GaugePointer>[
                              NeedlePointer(value: widget.ppm)
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                  widget: Container(
                                      child: Text(
                                          "       ppm\n     " +
                                              widget.ppm.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold))),
                                  angle: 90,
                                  positionFactor: 1)
                            ])
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: new Container(
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                            minimum: 0.0,
                            maximum: 100.0,
                            ranges: <GaugeRange>[
                              GaugeRange(
                                  startValue: 0.0,
                                  endValue: 50.0,
                                  color: Colors.blue),
                              GaugeRange(
                                  startValue: 50.0,
                                  endValue: 75.0,
                                  color: Colors.orange),
                              GaugeRange(
                                  startValue: 75.0,
                                  endValue: 100.0,
                                  color: Colors.red)
                            ],
                            pointers: <GaugePointer>[
                              NeedlePointer(value: widget.sicaklik)
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                  widget: Container(
                                      child: Text(
                                          "  Sicaklik\n  " +
                                              widget.sicaklik.toString() +
                                              "\u2103",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold))),
                                  angle: 90,
                                  positionFactor: 1)
                            ])
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: new Container(
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                            minimum: 0.0,
                            maximum: 100.0,
                            ranges: <GaugeRange>[
                              GaugeRange(
                                  startValue: 0.0,
                                  endValue: 50.0,
                                  color: Colors.blue),
                              GaugeRange(
                                  startValue: 50.0,
                                  endValue: 100.0,
                                  color: Colors.orange),
                            ],
                            pointers: <GaugePointer>[
                              NeedlePointer(value: widget.nem)
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                  widget: Container(
                                      child: Text(
                                          "      Nem\n     " +
                                              widget.nem.toString() +
                                              "%",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold))),
                                  angle: 90,
                                  positionFactor: 1)
                            ])
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: new Container(
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                            minimum: 0.0,
                            maximum: 500.0,
                            ranges: <GaugeRange>[
                              GaugeRange(
                                  startValue: 0.0,
                                  endValue: 250.0,
                                  color: Colors.blue),
                              GaugeRange(
                                  startValue: 250.0,
                                  endValue: 400.0,
                                  color: Colors.orange),
                              GaugeRange(
                                  startValue: 400.0,
                                  endValue: 500.0,
                                  color: Colors.red)
                            ],
                            pointers: <GaugePointer>[
                              NeedlePointer(value: widget.yaniciGaz)
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                  widget: Container(
                                      child: Text(
                                          "Yanici Gaz\n      " +
                                              widget.yaniciGaz.toString() +
                                              "%",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold))),
                                  angle: 90,
                                  positionFactor: 1)
                            ])
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                new Container(
                  width: 196,
                  height: 196,
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                          minimum: 0.0,
                          maximum: 500.0,
                          ranges: <GaugeRange>[
                            GaugeRange(
                                startValue: 0.0,
                                endValue: 500.0,
                                color: Colors.blue),
                          ],
                          pointers: <GaugePointer>[
                            NeedlePointer(value: widget.sensorVoltage)
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                widget: Container(
                                    child: Text(
                                        "Sensor Voltaji\n     " +
                                            widget.sensorVoltage.toString() +
                                            "\u2103",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))),
                                angle: 90,
                                positionFactor: 1)
                          ])
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                )
              ],
            ),
            PpmChart(widget: widget),
            SicaklikChart(widget: widget),
            NemChart(widget: widget),
            YaniciGazChart(widget: widget),
            SensorVoltageChart(widget: widget),
          ],
        ),
      ),
    );
  }
}
