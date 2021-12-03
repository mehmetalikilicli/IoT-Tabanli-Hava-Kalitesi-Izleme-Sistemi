import 'package:dhtdata/main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SensorVoltageChart extends StatelessWidget {
  const SensorVoltageChart({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final MyHomePage widget;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: ''),
      legend: Legend(isVisible: true),
      //tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        LineSeries<SensorVoltageData, double>(
            name: 'ppm',
            dataSource: widget.sensorVoltageData,
            xValueMapper: (SensorVoltageData sales, _) => sales.time,
            yValueMapper: (SensorVoltageData sales, _) => sales.sensorVoltage,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true)
      ],
      primaryXAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: NumericAxis(
        labelFormat: '{value}',
        //numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
      ),
    );
  }
}

class SensorVoltageData {
  SensorVoltageData(this.sensorVoltage, this.time);

  final double sensorVoltage;
  final double time;
}
