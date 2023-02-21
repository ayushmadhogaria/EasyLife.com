import 'package:easylifeapp/models/serviceman.dart';
import 'package:easylifeapp/screens/serviceman_detail_screen.dart';
import 'package:easylifeapp/services/home_service.dart';
import 'package:easylifeapp/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendedService extends StatefulWidget {
  const RecommendedService({super.key});

  @override
  State<RecommendedService> createState() => _RecommendedServiceState();
}

class _RecommendedServiceState extends State<RecommendedService> {
  Serviceman? serviceman;
  final HomeService homeService = HomeService();
  @override
  void initState() {
    super.initState();
    fetchRecommendedServiceman();
  }

  void fetchRecommendedServiceman() async {
    serviceman = await homeService.fetchRecommendedServiceman(context: context);
    setState(() {});
  }

  void navigateToServicemanDetialScreen() {
    Navigator.pushNamed(
      context,
      ServicemanDetailScreen.routeName,
      arguments: serviceman,
    );
  }

  @override
  Widget build(BuildContext context) {
    return serviceman == null
        ? const Loader()
        : serviceman!.name.isEmpty
            ? Column(
                children: [
                  Center(
                    child: SizedBox(
                      child: Image.asset(
                        'assets/noservice.PNG',
                      ),
                    ),
                  ),
                  const Text(
                    'No recommendation currently!',
                    style: TextStyle(
                        color: Color.fromARGB(255, 61, 117, 93),
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            : GestureDetector(
                onTap: navigateToServicemanDetialScreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                      child: const Text('Highly Recommended',
                          style: TextStyle(
                              color: Color.fromARGB(255, 32, 131, 118),
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                    ),
                    Image.network(
                      serviceman!.images[0],
                      height: 200.h,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(serviceman!.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 16, 94, 83),
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                          left: 15, top: 6, right: 40, bottom: 10),
                      child: Text(
                        serviceman!.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 16, 94, 83),
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
