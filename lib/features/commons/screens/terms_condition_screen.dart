import 'package:easylifeapp/features/customer/widgets/customer_terms.dart';
import 'package:easylifeapp/features/serviceman/widgets/serviceman_terms.dart';
import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';

void main() {
  runApp(const TermsAndConditionPage());
}

class TermsAndConditionPage extends StatelessWidget {
  static const String routeName = '/terms-screen';
  const TermsAndConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: GlobalVariables.backgroundcolor,
          appBar: AppBar(
            elevation: 0.5,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.buttoncolor),
            ),
            bottom: const TabBar(
              indicatorColor: Colors.black,
              tabs: [
                Tab(
                  child: Text('Customer Terms',
                      style: TextStyle(
                          color: Color.fromARGB(255, 29, 39, 35),
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                ),
                Tab(
                  child: Text('Serviceman Terms',
                      style: TextStyle(
                          color: Color.fromARGB(255, 29, 39, 35),
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                ),
              ],
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: const Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: Color.fromARGB(255, 57, 68, 63),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 75.0),
                  child: Text('Terms And Condition',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255, 29, 39, 35),
                          fontWeight: FontWeight.bold,
                          fontSize: 22)),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              CustomerTerms(),
              ServicemanTerms(),
            ],
          ),
        ),
      ),
    );
  }
}
