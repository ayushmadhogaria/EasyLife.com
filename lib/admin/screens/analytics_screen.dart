import 'package:easylifeapp/admin/services/admin_services.dart';
import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/models/transaction.dart';
import 'package:easylifeapp/widgets/loader.dart';
import 'package:flutter/material.dart';

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
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Total Earning : \Rs.$totalTransaction',
                    style: const TextStyle(
                        color: GlobalVariables.unselectednavbarcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              )
            ],
          );
  }
}
