import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendedService extends StatefulWidget {
  const RecommendedService({super.key});

  @override
  State<RecommendedService> createState() => _RecommendedServiceState();
}

class _RecommendedServiceState extends State<RecommendedService> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
          child: const Text('Highly Recommended',
              style: TextStyle(
                  color: Color.fromARGB(255, 32, 131, 118),
                  fontWeight: FontWeight.bold,
                  fontSize: 17)),
        ),
        Image.network(
          'https://images.unsplash.com/photo-1516862523118-a3724eb136d7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZHJpdmVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
          height: 200.h,
          fit: BoxFit.fitHeight,
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15),
          child: Text('Salary- \Rs. 100  ',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Color.fromARGB(255, 16, 94, 83),
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding:
              const EdgeInsets.only(left: 15, top: 6, right: 40, bottom: 10),
          child: Text(
            'Ayush is the best guy for driving your cars in the heavy traffic.',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color.fromARGB(255, 16, 94, 83),
            ),
          ),
        ),
      ],
    );
  }
}
