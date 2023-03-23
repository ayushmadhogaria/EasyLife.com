import 'package:easylifeapp/admin/services/admin_services.dart';
import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/models/appointment.dart';
import 'package:easylifeapp/providers/user_provider.dart';
import 'package:easylifeapp/screens/appointment_details.dart';
import 'package:easylifeapp/services/address_service.dart';
import 'package:easylifeapp/widgets/individual_booking.dart';
import 'package:easylifeapp/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  List<Appointment>? appointments;
  final AdminServices adminServices = AdminServices();
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  void fetchAppointments() async {
    appointments = await adminServices.fetchAllAppointments(context);
    setState(() {});
  }

  //delete the appointment
  void deleteAppointment(Appointment app, int index) {
    addressServices.deleteAppointment(
        context: context,
        appointment: app,
        onSuccess: () {
          appointments!.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return appointments == null
        ? const Loader()
        : Scaffold(
            backgroundColor: GlobalVariables.loggedinbackgroundcolor,
            body: GridView.builder(
                itemCount: appointments!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final appointmentData = appointments![index];

                  return GestureDetector(
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        AppointmentDetailScreen.routeName,
                        arguments: appointmentData,
                      );
                      fetchAppointments();
                    },
                    child: Column(
                      children: [
                        if (user.type == 'Admin')
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
                                        "Are you sure to delete this appointment?",
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
                                            onPressed: () {
                                              deleteAppointment(
                                                  appointmentData, index);
                                              Navigator.pop(context);
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
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SizedBox(
                            height: 140,
                            child: IndividualBooking(
                                image:
                                    appointmentData.servicemans[0].images[0]),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          );
  }
}
