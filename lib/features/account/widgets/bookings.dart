import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/features/address/services/address_service.dart';
import 'package:easylifeapp/models/appointment.dart';
import 'package:easylifeapp/features/appointment_detail/appointment_details.dart';
import 'package:easylifeapp/features/account/services/account_service.dart';
import 'package:easylifeapp/features/account/widgets/individual_booking.dart';
import 'package:easylifeapp/common/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  List<Appointment>? appointments;
  final AccountServices accountServices = AccountServices();
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  void fetchAppointments() async {
    appointments = await accountServices.fetchMyAppointments(
      context: context,
    );
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
    return appointments == null
        ? const Loader()
        : appointments!.isEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Column(
                  children: const [
                    Center(
                      child: SizedBox(
                          child: Icon(
                        Icons.book,
                        color: GlobalVariables.unselectednavbarcolor,
                        size: 50,
                      )),
                    ),
                    Text(
                      'No appointments booked yet! \n           Book our services.',
                      style: TextStyle(
                          color: Color.fromARGB(255, 61, 117, 93),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15, top: 20),
                        child: const Text('Your Appointments',
                            style: TextStyle(
                                color: Color.fromARGB(255, 16, 94, 83),
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 15, top: 20),
                        child: const Text('View all',
                            style: TextStyle(
                                color: Color.fromARGB(255, 16, 94, 83),
                                // fontWeight: FontWeight.bold,
                                fontSize: 15.5)),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 510,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemCount: appointments!.length,
                              itemBuilder: ((context, index) {
                                final appointmentData = appointments![index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppointmentDetailScreen.routeName,
                                      arguments: appointments![index],
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      IndividualBooking(
                                        image: appointmentData
                                            .servicemans[0].images[0],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 233, 250, 244),
                                                  title: const Text(
                                                    "Are you sure to delete this appointment?",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color.fromARGB(
                                                            255, 23, 59, 47)),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          "No",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      23,
                                                                      59,
                                                                      47)),
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          deleteAppointment(
                                                              appointmentData,
                                                              index);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          "Yes",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      23,
                                                                      59,
                                                                      47)),
                                                        )),
                                                  ],
                                                );
                                              });
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: GlobalVariables
                                              .unselectednavbarcolor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            )),
                      ),
                    ],
                  )
                ],
              );
  }
}
