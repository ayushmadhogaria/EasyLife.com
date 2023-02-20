import 'package:carousel_slider/carousel_slider.dart';
import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/models/serviceman.dart';
import 'package:easylifeapp/screens/search_screen.dart';
import 'package:easylifeapp/widgets/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServicemanDetailScreen extends StatefulWidget {
  static const String routeName = '/serviceman-details';
  final Serviceman serviceman;
  const ServicemanDetailScreen({super.key, required this.serviceman});

  @override
  State<ServicemanDetailScreen> createState() => _ServicemanDetailScreenState();
}

class _ServicemanDetailScreenState extends State<ServicemanDetailScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
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
              Expanded(
                child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(left: 10),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1.5,
                      child: TextFormField(
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
                                  color: GlobalVariables.selectednavbarcolor,
                                  size: 25,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 226, 253, 252),
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
                                  color: GlobalVariables.unselectednavbarcolor,
                                  width: 1.3),
                            ),
                            hintText: 'Search for EasyLife.com services',
                            hintStyle: const TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 76, 102, 91),
                                fontWeight: FontWeight.w400)),
                      ),
                    )),
              ),
              Container(
                color: Colors.transparent,
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: const Icon(
                  Icons.mic,
                  color: Colors.white,
                  size: 28,
                ),
              )
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
                const RatingStars(rating: 4),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: Column(
              children: [
                Text(
                  widget.serviceman.name,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 61, 117, 93),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
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
                    fit: BoxFit.cover,
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
        ],
      )),
    );
  }
}
