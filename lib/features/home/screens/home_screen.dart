import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/features/search_serviceman/screens/search_screen.dart';
import 'package:easylifeapp/features/home/widgets/address_box.dart';
import 'package:easylifeapp/features/home/widgets/carousal_slider.dart';
import 'package:easylifeapp/features/home/widgets/category_list.dart';
import 'package:easylifeapp/features/home/widgets/recommeneded_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSearchScreen(String query) {
    if (query.isEmpty) return;
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
    setState(() {
      _searchController.clear();
    });
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
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
              Expanded(
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
                margin: const EdgeInsets.symmetric(horizontal: 10),
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
          children: [
            const AddressDetail(),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: const Text("We are at your service.",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color.fromARGB(255, 32, 131, 118),
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
            const SizedBox(
              height: 10,
            ),
            const CategoryList(),
            const CarousalImage(),
            const RecommendedService(),
          ],
        ),
      ),
    );
  }
}
