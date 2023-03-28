import 'package:easylifeapp/admin/screens/add_serviceman_screen.dart';
import 'package:easylifeapp/admin/services/admin_services.dart';
import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/models/serviceman.dart';
import 'package:easylifeapp/screens/serviceman_detail_screen.dart';
import 'package:easylifeapp/widgets/individual_booking.dart';
import 'package:easylifeapp/widgets/loader.dart';
import 'package:flutter/material.dart';

class AllServiceManScreen extends StatefulWidget {
  const AllServiceManScreen({super.key});

  @override
  State<AllServiceManScreen> createState() => _AllServiceManScreenState();
}

class _AllServiceManScreenState extends State<AllServiceManScreen> {
  List<Serviceman>? serviceman;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllServiceman();
  }

  fetchAllServiceman() async {
    serviceman = await adminServices.fetchAllServiceman(context);
    setState(() {});
  }

  void deleteServiceman(Serviceman serviceMan, int index) {
    adminServices.deleteServiceman(
      context: context,
      serviceman: serviceMan,
      onSuccess: () {
        serviceman!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateToAddServiceMan() async {
    await Navigator.pushNamed(context, AddServiceManScreen.routeName);
    fetchAllServiceman();
  }

  @override
  Widget build(BuildContext context) {
    return serviceman == null
        ? const Loader()
        : Scaffold(
            backgroundColor: GlobalVariables.loggedinbackgroundcolor,
            body: GridView.builder(
              itemCount: serviceman!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final servicemanData = serviceman![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ServicemanDetailScreen.routeName,
                      arguments: servicemanData,
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        servicemanData.category,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 54, 83, 73),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          height: 120,
                          child: IndividualBooking(
                            image: servicemanData.images[0],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                servicemanData.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 54, 83, 73),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: const Color.fromARGB(
                                          255, 233, 250, 244),
                                      title: const Text(
                                        "Are you sure to delete this serviceman?",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(
                                                255, 23, 59, 47)),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "No",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromARGB(
                                                      255, 23, 59, 47)),
                                            )),
                                        TextButton(
                                            onPressed: () => {
                                                  deleteServiceman(
                                                      servicemanData, index),
                                                  Navigator.pop(context),
                                                },
                                            child: const Text(
                                              "Yes",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromARGB(
                                                      255, 23, 59, 47)),
                                            )),
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: GlobalVariables.unselectednavbarcolor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              foregroundColor: const Color.fromARGB(255, 49, 48, 48),
              backgroundColor: GlobalVariables.selectednavbarcolor,
              onPressed: navigateToAddServiceMan,
              tooltip: 'Add a serviceMan',
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
