import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/models/appointment.dart';
import 'package:easylifeapp/services/account_service.dart';
import 'package:easylifeapp/widgets/individual_booking.dart';
import 'package:easylifeapp/widgets/loader.dart';
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
                  Padding(
                    padding: EdgeInsets.only(top: 60.h),
                    child: Container(
                        height: 170,
                        padding:
                            const EdgeInsets.only(left: 10, top: 20, right: 0),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: appointments!.length,
                          itemBuilder: ((context, index) {
                            return IndividualBooking(
                              image:
                                  appointments![index].servicemans[0].images[0],
                            );
                          }),
                        )),
                  )
                ],
              );
  }
}
