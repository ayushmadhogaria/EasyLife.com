import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/models/serviceman.dart';
import 'package:easylifeapp/features/serviceman_detail/screens/serviceman_detail_screen.dart';
import 'package:easylifeapp/features/home/services/home_service.dart';
import 'package:easylifeapp/common/loader.dart';
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
        appBar: AppBar(
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
                : SizedBox(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(
                        15,
                      ),
                      itemCount: servicemanList!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
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
                                  child: Image.network(
                                    serviceman.images[0],
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
                  ));
  }
}
