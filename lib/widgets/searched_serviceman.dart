import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/models/serviceman.dart';
import 'package:easylifeapp/widgets/rating_stars.dart';
import 'package:flutter/material.dart';

class SearchedServiceman extends StatelessWidget {
  final Serviceman serviceman;
  const SearchedServiceman({
    super.key,
    required this.serviceman,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              children: [
                Image.network(
                  serviceman.images[0],
                  fit: BoxFit.fitHeight,
                  height: 150,
                  width: 135,
                ),
                Column(
                  children: [
                    Container(
                      width: 235,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        serviceman.name,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 61, 117, 93),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        serviceman.address,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 60, 92, 78),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: const RatingStars(
                          rating: 4,
                        )),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        'Salary - Rs. ${serviceman.salary}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 61, 117, 93),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 2),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.verified,
                            color: GlobalVariables.unselectednavbarcolor,
                            size: 20,
                          ),
                          Text(
                            " Professional and Experienced",
                            style: TextStyle(
                              color: Color.fromARGB(255, 61, 117, 93),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: const Text(
                        "Available for work",
                        style: TextStyle(
                            color: Color.fromARGB(255, 90, 116, 104),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ],
    );
  }
}
