import 'package:dhtdata/main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SicaklikChart extends StatelessWidget {
  const SicaklikChart({
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
        LineSeries<SicaklikData, double>(
            name: 'sicaklik',
            dataSource: widget.sicaklikData,
            xValueMapper: (SicaklikData sales, _) => sales.time,
            yValueMapper: (SicaklikData sales, _) => sales.sicaklik,
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

class SicaklikData {
  SicaklikData(this.sicaklik, this.time);

  final double sicaklik;
  final double time;
}
