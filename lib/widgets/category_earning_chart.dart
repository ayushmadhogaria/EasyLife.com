import 'package:easylifeapp/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;

class CategoryEarningChart extends StatelessWidget {
  final List<charts.Series<Transaction, String>> seriesList;
  const CategoryEarningChart({super.key, required this.seriesList});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}
