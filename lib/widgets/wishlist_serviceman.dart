import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/models/serviceman.dart';
import 'package:easylifeapp/providers/user_provider.dart';
import 'package:easylifeapp/services/serviceman_details_services.dart';
import 'package:easylifeapp/services/wishlist_service.dart';
import 'package:easylifeapp/widgets/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistServiceman extends StatefulWidget {
  final int index;

  const WishlistServiceman({super.key, required this.index});

  @override
  State<WishlistServiceman> createState() => _WishlistServicemanState();
}

class _WishlistServicemanState extends State<WishlistServiceman> {
  final ServicemanDetailsServices servicemanDetailsServices =
      ServicemanDetailsServices();
  final WishlistService wishlistService = WishlistService();

  void increaseDuration(Serviceman serviceman) {
    servicemanDetailsServices.addToWishlist(
      context: context,
      serviceman: serviceman,
    );
  }

  void decreaseDuration(Serviceman serviceman) {
    wishlistService.removeFromWishlist(
      context: context,
      serviceman: serviceman,
    );
  }

  @override
  Widget build(BuildContext context) {
    final servicemanWishlist =
        context.watch<UserProvider>().user.wishlist[widget.index];
    final serviceman = Serviceman.fromMap(servicemanWishlist['serviceman']);
    final duration = servicemanWishlist['duration'];

    double totalRating = 0;
    for (int i = 0; i < serviceman.rating!.length; i++) {
      totalRating += serviceman.rating![i].rating;
    }
    double avgRating = 0;
    if (totalRating != 0) {
      avgRating = totalRating / serviceman.rating!.length;
    }
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
                fit: BoxFit.contain,
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
                      child: RatingStars(
                        rating: avgRating,
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
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: GlobalVariables.unselectednavbarcolor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(255, 203, 240, 224),
                ),
                child: Row(children: [
                  InkWell(
                    onTap: () => decreaseDuration(serviceman),
                    child: Container(
                      width: 25,
                      height: 25,
                      alignment: Alignment.center,
                      child: const Icon(Icons.remove, size: 18),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 203, 240, 224),
                            width: 1.5),
                        color: GlobalVariables.loggedinbackgroundcolor,
                        borderRadius: BorderRadius.circular(0)),
                    child: Container(
                        width: 30,
                        height: 25,
                        alignment: Alignment.center,
                        child: Text(
                          duration.toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 90, 116, 104),
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  InkWell(
                    onTap: () => increaseDuration(serviceman),
                    child: Container(
                      width: 25,
                      height: 25,
                      alignment: Alignment.center,
                      child: const Icon(Icons.add, size: 18),
                    ),
                  ),
                ]),
              )
            ],
          ),
        )
      ],
    );
  }
}
