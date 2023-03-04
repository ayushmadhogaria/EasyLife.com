import 'package:easylifeapp/admin/services/admin_services.dart';
import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/models/appointment.dart';
import 'package:easylifeapp/screens/appointment_details.dart';
import 'package:easylifeapp/widgets/individual_booking.dart';
import 'package:easylifeapp/widgets/loader.dart';
import 'package:flutter/material.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  List<Appointment>? appointments;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  void fetchAppointments() async {
    appointments = await adminServices.fetchAllAppointments(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppointmentDetailScreen.routeName,
                        arguments: appointmentData,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        height: 140,
                        child: IndividualBooking(
                            image: appointmentData.servicemans[0].images[0]),
                      ),
                    ),
                  );
                }),
          );
  }
}
