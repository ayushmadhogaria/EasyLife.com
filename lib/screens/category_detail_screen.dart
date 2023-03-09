import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/models/serviceman.dart';
import 'package:easylifeapp/screens/serviceman_detail_screen.dart';
import 'package:easylifeapp/services/home_service.dart';
import 'package:easylifeapp/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryDetailsScreen extends StatefulWidget {
  static const String routeName = '/category-details';
  final String category;
  const CategoryDetailsScreen({
    super.key,
    required this.category,
  });

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  List<Serviceman>? servicemanList;
  final HomeService homeService = HomeService();

  @override
  void initState() {
    super.initState();
    fetchCategoryServiceman();
  }

  Future<void> fetchCategoryServiceman() async {
    servicemanList = await homeService.fetchCategoryServiceman(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.loggedinbackgroundcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: AppBar(
          elevation: 0.5,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(color: GlobalVariables.backgroundcolor),
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
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Text(
                  'Hire ${widget.category}',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 61, 117, 93),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/project_logo.png',
                  width: 80.h,
                  height: 40.h,
                ),
              ),
            ],
          ),
        ),
      ),
      body: servicemanList == null
          ? const Loader()
          : servicemanList!.isEmpty
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
                        'No serviceman available in this category currently! \n                          Sorry for inconvinience.',
                        style: TextStyle(
                            color: Color.fromARGB(255, 61, 117, 93),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              : Column(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Hire professional ${widget.category} For Better Lifestyle',
                      style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 61, 117, 93),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 170,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      itemCount: servicemanList!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.4,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: ((context, index) {
                        final serviceman = servicemanList![index];
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.pushNamed(
                              context,
                              ServicemanDetailScreen.routeName,
                              arguments: serviceman,
                            );
                            fetchCategoryServiceman();
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 130,
                                width: double.infinity,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          GlobalVariables.unselectednavbarcolor,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.network(
                                      serviceman.images[0],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(
                                    left: 0, top: 5, right: 15),
                                child: Text(
                                  serviceman.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 61, 117, 93),
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  )
                ]),
    );
  }
}
