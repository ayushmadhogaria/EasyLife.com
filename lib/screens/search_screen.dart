import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/models/serviceman.dart';
import 'package:easylifeapp/screens/serviceman_detail_screen.dart';
import 'package:easylifeapp/services/search_service.dart';
import 'package:easylifeapp/widgets/address_box.dart';
import 'package:easylifeapp/widgets/loader.dart';
import 'package:easylifeapp/widgets/searched_serviceman.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({
    super.key,
    required this.searchQuery,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Serviceman>? serviceman;
  final SearchService searchService = SearchService();

  @override
  void initState() {
    super.initState();
    fetchSearchedServiceman();
  }

  fetchSearchedServiceman() async {
    serviceman = await searchService.fetchSearchedServiceman(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    if (query.length < 1) return;
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
                    color: GlobalVariables.selectednavbarcolor,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Container(
                      height: 40,
                      margin: const EdgeInsets.only(left: 15),
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
        body: serviceman == null
            ? const Loader()
            : Column(
                children: [
                  const AddressDetail(),
                  const SizedBox(
                    height: 10,
                  ),
                  serviceman!.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child: Column(
                            children: [
                              Center(
                                child: SizedBox(
                                  child: Image.asset(
                                    'assets/noservice.PNG',
                                  ),
                                ),
                              ),
                              const Text(
                                'No serviceman of this name exists! \n    Try searching valid serviceman.',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 61, 117, 93),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: serviceman!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, ServicemanDetailScreen.routeName,
                                      arguments: serviceman![index]);
                                },
                                child: SearchedServiceman(
                                    serviceman: serviceman![index]),
                              );
                            },
                          ),
                        ),
                ],
              ));
  }
}
