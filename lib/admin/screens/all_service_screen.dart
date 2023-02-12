import 'package:easylifeapp/admin/screens/add_serviceman_screen.dart';
import 'package:easylifeapp/constants/global_variables.dart';
import 'package:flutter/material.dart';

class AllServiceManScreen extends StatefulWidget {
  const AllServiceManScreen({super.key});

  @override
  State<AllServiceManScreen> createState() => _AllServiceManScreenState();
}

class _AllServiceManScreenState extends State<AllServiceManScreen> {
  void navigateToAddServiceMan() {
    Navigator.pushNamed(context, AddServiceManScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('ServiceMan'),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: const Color.fromARGB(255, 49, 48, 48),
        backgroundColor: GlobalVariables.selectednavbarcolor,
        onPressed: navigateToAddServiceMan,
        tooltip: 'Add a serviceMan',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
