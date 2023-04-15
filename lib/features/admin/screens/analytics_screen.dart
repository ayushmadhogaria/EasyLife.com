import 'package:easylifeapp/features/admin/services/admin_services.dart';
import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/features/admin/models/transaction.dart';
import 'package:easylifeapp/features/admin/widgets/category_earning_chart.dart';
import 'package:easylifeapp/common/loader.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalTransaction;
  List<Transaction>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalTransaction = earningData['totalEarnings'];
    earnings = earningData['transaction'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalTransaction == null
        ? const Loader()
        : Scaffold(
            backgroundColor: GlobalVariables.loggedinbackgroundcolor,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: Text(
                      'Total Earning : Rs.$totalTransaction',
                      style: const TextStyle(
                          color: GlobalVariables.unselectednavbarcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 300,
                    child: CategoryEarningChart(seriesList: [
                      charts.Series(
                          id: 'Transaction',
                          colorFn: (_, __) =>
                              charts.Color.fromHex(code: '#67a395'),
                          data: earnings!,
                          domainFn: (Transaction transation, _) =>
                              transation.label,
                          measureFn: (Transaction transation, _) =>
                              transation.earning),
                    ]),
                  ),
                )
              ],
            ),
          );
  }
}
