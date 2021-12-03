import 'package:dhtdata/main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NemChart extends StatelessWidget {
  const NemChart({
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
        LineSeries<NemData, double>(
            name: 'nem',
            dataSource: widget.nemData,
            xValueMapper: (NemData sales, _) => sales.time,
            yValueMapper: (NemData sales, _) => sales.nem,
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

class NemData {
  NemData(this.nem, this.time);

  final double nem;
  final double time;
}
