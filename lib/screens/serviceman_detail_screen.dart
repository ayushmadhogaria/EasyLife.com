import 'package:carousel_slider/carousel_slider.dart';
import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/models/serviceman.dart';
import 'package:easylifeapp/providers/navigation_provider.dart';
import 'package:easylifeapp/providers/user_provider.dart';
import 'package:easylifeapp/screens/map_screen.dart';
import 'package:easylifeapp/screens/search_screen.dart';
import 'package:easylifeapp/services/serviceman_details_services.dart';
import 'package:easylifeapp/widgets/bottom_bar.dart';
import 'package:easylifeapp/widgets/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicemanDetailScreen extends StatefulWidget {
  static const String routeName = '/serviceman-details';
  final Serviceman serviceman;
  const ServicemanDetailScreen({super.key, required this.serviceman});

  @override
  State<ServicemanDetailScreen> createState() => _ServicemanDetailScreenState();
}

class _ServicemanDetailScreenState extends State<ServicemanDetailScreen> {
  final ServicemanDetailsServices servicemanDetailsServices =
      ServicemanDetailsServices();
  double avgRating = 0;
  double myRating = 0;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.serviceman.rating!.length; i++) {
      totalRating += widget.serviceman.rating![i].rating;
      if (widget.serviceman.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.serviceman.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.serviceman.rating!.length;
    }
  }

  void navigateToSearchScreen(String query) {
    if (query.isEmpty) return;
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);

    setState(() {
      _searchController.clear();
    });
  }

  void addToWishlist() {
    servicemanDetailsServices.addToWishlist(
        context: context, serviceman: widget.serviceman);
    Navigator.pushNamed(context, BottomBar.routeName);
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: GlobalVariables.loggedinbackgroundcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          elevation: 0.5,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.buttoncolor),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Color.fromARGB(255, 57, 68, 63),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Builder(builder: (context) {
                if (user.type == 'Customer') {
                  return Expanded(
                    child: Container(
                        height: 40,
                        margin: const EdgeInsets.only(left: 10),
                        child: Material(
                          borderRadius: BorderRadius.circular(7),
                          elevation: 1.5,
                          child: TextFormField(
                            controller: _searchController,
                            cursorColor: GlobalVariables.unselectednavbarcolor,
                            style: const TextStyle(
                                color: GlobalVariables.unselectednavbarcolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            onFieldSubmitted: navigateToSearchScreen,
                            decoration: InputDecoration(
                                prefixIcon: InkWell(
                                  onTap: () {},
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 7),
                                    child: Icon(
                                      Icons.search,
                                      color:
                                          GlobalVariables.selectednavbarcolor,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 226, 253, 252),
                                contentPadding: const EdgeInsets.only(top: 10),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                  borderSide: BorderSide(
                                      color:
                                          GlobalVariables.unselectednavbarcolor,
                                      width: 1.3),
                                ),
                                hintText: 'Search for EasyLife.com services',
                                hintStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 76, 102, 91),
                                    fontWeight: FontWeight.w400)),
                          ),
                        )),
                  );
                } else {
                  return const Text('Serviceman Detail Screen',
                      style: TextStyle(
                          color: Color.fromARGB(255, 16, 94, 83),
                          fontWeight: FontWeight.bold,
                          fontSize: 18));
                }
              }),
              Builder(builder: (context) {
                if (user.type == 'Customer') {
                  return Container(
                    color: Colors.transparent,
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: const Icon(
                      Icons.mic,
                      color: Colors.white,
                      size: 28,
                    ),
                  );
                } else {
                  return Container();
                }
              })
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.serviceman.id!,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 61, 117, 93),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            CarouselSlider(
              items: widget.serviceman.images.map(
                (i) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.contain,
                      height: 200,
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                enableInfiniteScroll: false,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: Colors.black12,
                height: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
              child: Row(
                children: [
                  Text(
                    widget.serviceman.name,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 61, 117, 93),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 230.0),
                    child: RatingStars(
                      rating: avgRating,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                height: 2,
                color: Colors.black12,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => {
                          {
                            Navigator.pushNamed(context, MapScreen.routeName),
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.pin_drop_sharp,
                            size: 20,
                            color: Color.fromARGB(255, 61, 117, 93),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          {
                            Navigator.pushNamed(context, MapScreen.routeName),
                          }
                        },
                        child: Text(
                          widget.serviceman.address,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 61, 117, 93),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 10),
                        child: Text(
                          '|',
                          style: TextStyle(
                              color: Color.fromARGB(255, 61, 117, 93),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.phone,
                              size: 20,
                              color: Color.fromARGB(255, 61, 117, 93),
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              widget.serviceman.phone,
                              style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 2,
                                  color: Color.fromARGB(255, 61, 117, 93),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () =>
                                // ignore: deprecated_member_use
                                launch('tel:${widget.serviceman.phone}'),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 10),
                        child: Text(
                          '|',
                          style: TextStyle(
                              color: Color.fromARGB(255, 61, 117, 93),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: Icon(
                              Icons.timelapse,
                              size: 20,
                              color: Color.fromARGB(255, 61, 117, 93),
                            ),
                          ),
                          Text(
                            widget.serviceman.time,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 61, 117, 93),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.access_alarm,
                            size: 20,
                            color: Color.fromARGB(255, 61, 117, 93),
                          ),
                        ),
                        Text(
                          widget.serviceman.shift,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 61, 117, 93),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 75.0),
                          child: RichText(
                            text: TextSpan(
                              text: 'Salary - ',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 61, 117, 93),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: 'Rs. ${widget.serviceman.salary}',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 41, 68, 56),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                height: 2,
                color: Colors.black12,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.serviceman.description,
                style: const TextStyle(
                    color: Color.fromARGB(255, 61, 117, 93),
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                height: 2,
                color: Colors.black12,
              ),
            ),
            Builder(builder: (context) {
              if (user.type == 'Customer') {
                return GestureDetector(
                  onTap: () {
                    servicemanDetailsServices.addToWishlist(
                        context: context, serviceman: widget.serviceman);
                    context.read<NavigationProvider>().selectedIndex = 2;
                    Navigator.pushNamed(context, BottomBar.routeName);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 40.h, left: 40.h, top: 20.h),
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 166, 201, 197),
                              Color.fromARGB(255, 115, 155, 153)
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Color(0xffEEEEEE))
                        ]),
                    child: const Text(
                      "Book An Appointment",
                      style: TextStyle(
                          color: Color.fromARGB(255, 30, 70, 60),
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                );
              } else {
                return const SizedBox(
                  height: 0,
                );
              }
            }),
            Builder(builder: (context) {
              if (user.type == 'Customer') {
                return GestureDetector(
                  onTap: addToWishlist,
                  child: Container(
                    margin: EdgeInsets.only(right: 40.h, left: 40.h, top: 10.h),
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 166, 201, 197),
                              Color.fromARGB(255, 115, 155, 153)
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Color(0xffEEEEEE))
                        ]),
                    child: const Text(
                      "Add to Wishlist",
                      style: TextStyle(
                          color: Color.fromARGB(255, 30, 70, 60),
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                );
              } else {
                return const SizedBox(
                  height: 0,
                );
              }
              ;
            }),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Container(
                height: 2,
                color: Colors.black12,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text("Rate Your Experience",
                  style: TextStyle(
                      color: Color.fromARGB(255, 16, 94, 83),
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: RatingBar.builder(
                  initialRating: myRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: GlobalVariables.unselectednavbarcolor,
                      ),
                  onRatingUpdate: (rating) {
                    servicemanDetailsServices.rateServiceman(
                        context: context,
                        serviceman: widget.serviceman,
                        rating: rating);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
