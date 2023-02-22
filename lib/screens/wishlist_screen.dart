import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/screens/search_screen.dart';
import 'package:easylifeapp/widgets/address_box.dart';
import 'package:easylifeapp/widgets/service_total.dart';
import 'package:easylifeapp/widgets/wishlist_serviceman.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  void navigateToSearchScreen(String query) {
    if (query.length < 1) return;
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
    final user = context.watch<UserProvider>().user;
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
        children: [
          const AddressDetail(),
          const ServiceTotal(),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: 30.h, left: 30.h, top: 10.h),
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 166, 201, 197),
                    Color.fromARGB(255, 115, 155, 153)
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE))
                  ]),
              child: Text(
                "Proceed for appointment (${user.wishlist.length} services)",
                style: const TextStyle(
                    color: Color.fromARGB(255, 30, 70, 60),
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            color: Colors.black12.withOpacity(0.08),
            height: 1,
          ),
          const SizedBox(height: 5),
          ListView.builder(
            itemBuilder: (context, index) {
              return WishlistServiceman(
                index: index,
              );
            },
            itemCount: user.wishlist.length,
            shrinkWrap: true,
          )
        ],
      )),
    );
  }
}
