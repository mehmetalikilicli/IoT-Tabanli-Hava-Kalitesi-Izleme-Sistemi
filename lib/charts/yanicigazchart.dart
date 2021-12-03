import 'package:dhtdata/main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class YaniciGazChart extends StatelessWidget {
  const YaniciGazChart({
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
        LineSeries<YaniciGazData, double>(
            name: 'ppm',
            dataSource: widget.yaniciGazData,
            xValueMapper: (YaniciGazData sales, _) => sales.time,
            yValueMapper: (YaniciGazData sales, _) => sales.yaniciGaz,
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

class YaniciGazData {
  YaniciGazData(this.yaniciGaz, this.time);

  final double yaniciGaz;
  final double time;
}
