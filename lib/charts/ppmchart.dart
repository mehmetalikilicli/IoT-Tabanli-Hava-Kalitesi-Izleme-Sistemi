import 'package:dhtdata/main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PpmChart extends StatelessWidget {
  const PpmChart({
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
        LineSeries<PpmData, double>(
            name: 'ppm',
            dataSource: widget.ppmData,
            xValueMapper: (PpmData sales, _) => sales.time,
            yValueMapper: (PpmData sales, _) => sales.ppm,
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

class PpmData {
  PpmData(this.ppm, this.time);

  final double ppm;
  final double time;
}
