import 'package:easylifeapp/admin/services/admin_services.dart';
import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/models/appointment.dart';
import 'package:easylifeapp/providers/user_provider.dart';
import 'package:easylifeapp/screens/map_screen.dart';
import 'package:easylifeapp/screens/search_screen.dart';
import 'package:easylifeapp/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentDetailScreen extends StatefulWidget {
  static const String routeName = '/appointment-details';
  final Appointment appointment;
  const AppointmentDetailScreen({
    super.key,
    required this.appointment,
  });

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  int currentStep = 0;
  StepState completedStep = StepState.disabled;
  final AdminServices adminServices = AdminServices();

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
  void initState() {
    super.initState();
    currentStep = widget.appointment.status;
  }

  //admin and serviceman function for changing appointment status
  void changeAppointmentStatus(int status) {
    adminServices.changeAppointmentStatus(
      context: context,
      status: status + 1,
      appointment: widget.appointment,
      onSuccess: () {
        setState(() {
          currentStep += 1;
        });
      },
    );
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
                  return const Text('Appointment Screen',
                      style: TextStyle(
                          color: Color.fromARGB(255, 9, 39, 35),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('View appointment details',
                  style: TextStyle(
                      color: Color.fromARGB(255, 16, 94, 83),
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: GlobalVariables.unselectednavbarcolor,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customer Name:  ${widget.appointment.userName}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 50, 77, 65),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    GestureDetector(
                        child: RichText(
                          text: TextSpan(children: [
                            const TextSpan(
                              text: "Contact Details: ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 50, 77, 65),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            TextSpan(
                              text: widget.appointment.userContact,
                              style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color.fromARGB(255, 50, 77, 65),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ]),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return Container(
                                  height: 150,
                                  decoration: const BoxDecoration(
                                      color: GlobalVariables.backgroundcolor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                      )),
                                  child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Contact Via',
                                            style: TextStyle(
                                                fontSize: 18,
                                                height: 2,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 55, 77, 68)),
                                          ),
                                          InkWell(
                                            child: const Icon(
                                              Icons.close,
                                              color: Color.fromARGB(
                                                  255, 57, 68, 63),
                                            ),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20, top: 20),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.message,
                                            size: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // ignore: deprecated_member_use
                                              launch(
                                                  'sms:  ${widget.appointment.userContact}');
                                            },
                                            child: const Text(
                                              '      Send SMS',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 55, 77, 68)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20, top: 20),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.phone,
                                            size: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // ignore: deprecated_member_use
                                              launch(
                                                  'tel: + ${widget.appointment.userContact}');
                                            },
                                            child: Text(
                                              '      ${widget.appointment.userContact}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 55, 77, 68)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                );
                              });
                        }),
                    Text(
                      'Customer Address:  ${widget.appointment.address}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 50, 77, 65),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () => {
                        {
                          Navigator.pushNamed(context, MapScreen.routeName),
                        }
                      },
                      child: const Text(
                        '(Show in maps)',
                        style: TextStyle(
                            color: Color.fromARGB(255, 48, 10, 7),
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: GlobalVariables.unselectednavbarcolor,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Appointment Placed At: ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.appointment.requestedAt))}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 50, 77, 65),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    const Text(''),
                    Text(
                      'Appointment ID:  ${widget.appointment.id}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 50, 77, 65),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    const Text(''),
                    Text(
                      'Service Total: Rs.${widget.appointment.totalAmount} ',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 50, 77, 65),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    const Text(''),
                    Text(
                      'Appointment Date: ${widget.appointment.appointDate}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 50, 77, 65),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    const Text(''),
                    Text(
                      'Appointment Time: ${widget.appointment.appointTime}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 50, 77, 65),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Appointment details',
                  style: TextStyle(
                      color: Color.fromARGB(255, 16, 94, 83),
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: GlobalVariables.unselectednavbarcolor,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0;
                        i < widget.appointment.servicemans.length;
                        i++)
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              widget.appointment.servicemans[i].images[0],
                              height: 120,
                              width: 120,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.appointment.servicemans[i].name,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 50, 77, 65),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              GestureDetector(
                                // ignore: deprecated_member_use
                                onTap: () => launch(
                                    'tel:${widget.appointment.servicemans[i].phone}'),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Contact: ',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 50, 77, 65),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    Text(
                                      widget.appointment.servicemans[i].phone,
                                      style: const TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationThickness: 2,
                                          color:
                                              Color.fromARGB(255, 50, 77, 65),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Duration: ${widget.appointment.duration[i]} hrs/days',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 50, 77, 65),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            ],
                          ))
                        ],
                      )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //appointment status
              const Text('Track appointment status',
                  style: TextStyle(
                      color: Color.fromARGB(255, 16, 94, 83),
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: GlobalVariables.unselectednavbarcolor,
                  ),
                ),
                child: Theme(
                  data: ThemeData(
                      // ignore: deprecated_member_use
                      accentColor: const Color.fromARGB(255, 85, 72, 52),
                      primarySwatch: Colors.blue,
                      colorScheme: const ColorScheme.light(
                          primary: Color.fromARGB(255, 31, 58, 52))),
                  child: Stepper(
                    currentStep: currentStep,
                    controlsBuilder: ((context, details) {
                      if (user.type == 'Admin' || user.type == 'Serviceman') {
                        if (currentStep == 0) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentStep += 1;
                                      changeAppointmentStatus(
                                          details.currentStep + 1);
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          gradient: GlobalVariables.buttoncolor,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: const [
                                            BoxShadow(
                                                offset: Offset(0, 10),
                                                blurRadius: 50,
                                                color: Color(0xffEEEEEE))
                                          ]),
                                      child: const Text(
                                        "Accept",
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 36, 63, 59),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    changeAppointmentStatus(
                                        details.currentStep);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          gradient: GlobalVariables.buttoncolor,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: const [
                                            BoxShadow(
                                                offset: Offset(0, 10),
                                                blurRadius: 50,
                                                color: Color(0xffEEEEEE))
                                          ]),
                                      child: const Text(
                                        "Decline",
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 36, 63, 59),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (currentStep == 2) {
                          return CustomButton(
                              text: 'Done',
                              onTap: () {
                                if (currentStep < 2) {
                                  // changeAppointmentStatus(details.currentStep);
                                } else if (currentStep == 2) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          backgroundColor: const Color.fromARGB(
                                              255, 247, 247, 247),
                                          title: Row(
                                            children: const [
                                              Icon(
                                                Icons.wallet,
                                                size: 20,
                                                color: Color.fromARGB(
                                                    255, 51, 66, 60),
                                              ),
                                              Text(
                                                'Confirm payment information',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 51, 66, 60),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                          content: Text(
                                            'Rs.${widget.appointment.totalAmount}',
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 51, 66, 60),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  changeAppointmentStatus(
                                                      details.currentStep);

                                                  setState(() {
                                                    // currentStep += 1;
                                                    completedStep =
                                                        StepState.complete;
                                                  });
                                                },
                                                child: const Text(
                                                  "Complete appointment",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromARGB(
                                                          255, 99, 24, 24)),
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromARGB(
                                                          255, 23, 59, 47)),
                                                )),
                                          ],
                                        );
                                      });
                                }
                              });
                        }
                      }
                      return const SizedBox();
                    }),
                    physics: const ScrollPhysics(),
                    steps: [
                      Step(
                        title: const Text('Pending'),
                        content: const Text('Appointment yet to be responded.'),
                        isActive: currentStep >= 0,
                        state: currentStep > 0
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: const Text('Declined'),
                        content: const Text(
                            'Your appointment has been declined.Sorry for inconvinience.'),
                        isActive: currentStep >= 1,
                        state: currentStep == 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: const Text('Ongoing'),
                        content: const Text(
                            'Your service is accepted and will be carried out as per the appointment.'),
                        isActive: currentStep >= 2,
                        state: currentStep > 2
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: const Text('Completed'),
                        content:
                            const Text('Your appointment has been completed.'),
                        isActive: currentStep >= 3,
                        state: currentStep > 2
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
