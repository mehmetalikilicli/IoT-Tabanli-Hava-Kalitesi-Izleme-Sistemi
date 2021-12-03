import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Kadran extends StatefulWidget {
  Kadran(this.veri, {Key key}) : super(key: key);

  String veri;

  @override
  _KadranState createState() => _KadranState();
}

class _KadranState extends State<Kadran> {
  Future<void> _getDht() async {
    var url = Uri.parse(
        "https://api.thingspeak.com/channels/1588787/feeds.json?api_key=GKEQ7ZDQH706TVGZ&results=2");

    while (true) {
      var result = await http.get(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.veri),
    );
  }
}
