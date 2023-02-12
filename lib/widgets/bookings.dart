import 'package:easylifeapp/widgets/individual_booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  List list = [
    'https://plus.unsplash.com/premium_photo-1664443944765-904f4ba4b9fc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Y2xlYW5lcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    'https://plus.unsplash.com/premium_photo-1664443944765-904f4ba4b9fc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Y2xlYW5lcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    'https://plus.unsplash.com/premium_photo-1664443944765-904f4ba4b9fc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Y2xlYW5lcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    'https://plus.unsplash.com/premium_photo-1664443944765-904f4ba4b9fc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Y2xlYW5lcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15, top: 20),
              child: const Text('Your Bookings',
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
              padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: ((context, index) {
                  return IndividualBooking(
                    image: list[index],
                  );
                }),
              )),
        )
      ],
    );
  }
}
