import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/constants/utils.dart';
import 'package:easylifeapp/providers/navigation_provider.dart';
import 'package:easylifeapp/providers/user_provider.dart';
import 'package:easylifeapp/services/address_service.dart';
import 'package:easylifeapp/widgets/appointment_textfield.dart';
import 'package:easylifeapp/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController localityController = TextEditingController();
  final TextEditingController wardController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  String userAddress = "";

  DateTime? _date;
  TimeOfDay? _time;

  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    houseNumberController.dispose();
    localityController.dispose();
    wardController.dispose();
    districtController.dispose();
    super.dispose();
  }

  void onPayResult() async {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(context: context, address: userAddress);
    }
    await addressServices.bookAppointment(
        context: context,
        address: userAddress,
        userName: userAddress,
        appointDate: DateFormat.yMMMEd().format(_date!),
        appointTime: _time.toString(),
        totalAmount: double.parse(widget.totalAmount));
  }

  void payPressed(String addressFormProvider) {
    userAddress = "";
    bool isForm = houseNumberController.text.isNotEmpty ||
        localityController.text.isNotEmpty ||
        wardController.text.isNotEmpty ||
        districtController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        userAddress =
            '${houseNumberController.text},${localityController.text}-${wardController.text}|${districtController.text}';
      } else {
        throw Exception('Kindly fill all the values!');
      }
    } else if (addressFormProvider.isNotEmpty) {
      userAddress = addressFormProvider;
    } else {
      showSnackBar(context, 'Error!!');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    _dateString() {
      if (_date == null) {
        return 'Date';
      } else {
        return '${_date?.day}-${_date?.month}-${_date?.year}';
      }
    }

    // ignore: no_leading_underscores_for_local_identifiers
    _timeString() {
      if (_time == null) {
        return 'Time slot';
      } else {
        return '${_time?.hour}:${_time?.minute}';
      }
    }

    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      backgroundColor: GlobalVariables.loggedinbackgroundcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
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
                  color: Color.fromARGB(255, 44, 51, 48),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Padding(
                padding: EdgeInsets.only(right: 85.0),
                child: Text(
                  'Proceed for appointment',
                  style: TextStyle(
                    color: Color.fromARGB(255, 51, 66, 60),
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    final result = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: GlobalVariables
                                  .loggedinbackgroundcolor, // <-- SEE HERE
                              onPrimary: Colors.black, // <-- SEE HERE
                              onSurface: Colors.black, // <-- SEE HERE
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                // ignore: deprecated_member_use
                                primary: GlobalVariables
                                    .unselectednavbarcolor, // button text color
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (result != null) {
                      setState(() {
                        _date = result;
                      });
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10.h, left: 10, right: 40),
                    alignment: Alignment.center,
                    height: 30,
                    width: 160,
                    decoration: BoxDecoration(
                        gradient: GlobalVariables.buttoncolor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Color(0xffEEEEEE))
                        ]),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.date_range,
                            color: Color.fromARGB(255, 50, 77, 65),
                          ),
                        ),
                        Text(
                          '  Select date',
                          style: TextStyle(
                              color: Color.fromARGB(255, 50, 77, 65),
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final timeresult = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      initialEntryMode: TimePickerEntryMode.dial,
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: GlobalVariables
                                  .unselectednavbarcolor, // <-- SEE HERE
                              onPrimary: Colors.black, // <-- SEE HERE
                              onSurface: Colors.black, // <-- SEE HERE
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: GlobalVariables
                                    .unselectednavbarcolor, // button text color
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (timeresult != null) {
                      setState(() {
                        _time = timeresult;
                      });
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10.h),
                    alignment: Alignment.center,
                    height: 30,
                    width: 160,
                    decoration: BoxDecoration(
                        gradient: GlobalVariables.buttoncolor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Color(0xffEEEEEE))
                        ]),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.alarm,
                            color: Color.fromARGB(255, 50, 77, 65),
                          ),
                        ),
                        Text(
                          '  Select time',
                          style: TextStyle(
                              color: Color.fromARGB(255, 50, 77, 65),
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 8, right: 8),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: GlobalVariables.unselectednavbarcolor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 50.0),
                            child: Text(
                              _dateString(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 51, 66, 60),
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 50.0),
                            child: Text(
                              '|',
                              style: TextStyle(
                                color: Color.fromARGB(255, 51, 66, 60),
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50.0),
                            child: Text(
                              _timeString(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 51, 66, 60),
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            if (address.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: GlobalVariables.unselectednavbarcolor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 51, 66, 60),
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(
                        color: Color.fromARGB(255, 51, 66, 60),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
              ),
            Form(
              key: _addressFormKey,
              child: Column(
                children: [
                  AppointmentTextField(
                    controller: houseNumberController,
                    hintText: 'House number/Flat number',
                    icon: const Icon(
                      Icons.house,
                      color: Color.fromARGB(255, 54, 83, 73),
                    ),
                  ),
                  AppointmentTextField(
                    controller: localityController,
                    hintText: 'Locality/Area',
                    icon: const Icon(
                      Icons.area_chart,
                      color: Color.fromARGB(255, 54, 83, 73),
                    ),
                  ),
                  AppointmentTextField(
                    controller: wardController,
                    hintText: 'Ward number/Pincode',
                    icon: const Icon(
                      Icons.location_pin,
                      color: Color.fromARGB(255, 54, 83, 73),
                    ),
                  ),
                  AppointmentTextField(
                    controller: districtController,
                    hintText: 'District/City',
                    icon: const Icon(
                      Icons.location_city,
                      color: Color.fromARGB(255, 54, 83, 73),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      payPressed(address),
                      paymentItems,
                      if (_date == null || _time == null)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "You need to select the date and time slot for appointment.",
                              ),
                            ),
                          ),
                        }
                      else
                        {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor:
                                      const Color.fromARGB(255, 247, 247, 247),
                                  title: Row(
                                    children: const [
                                      Icon(
                                        Icons.wallet,
                                        size: 20,
                                        color: Color.fromARGB(255, 51, 66, 60),
                                      ),
                                      Text(
                                        ' Confirm Payment Information',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 51, 66, 60),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                  content: Text(
                                    'Rs.${widget.totalAmount}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 51, 66, 60),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  // content: TextField(
                                  //   controller: _paymenttextController,
                                  //   decoration: InputDecoration(
                                  //     hintText: 'Rs. ${widget.totalAmount}',
                                  //     hintStyle: const TextStyle(
                                  //       color: Color.fromARGB(255, 51, 66, 60),
                                  //       fontSize: 17,
                                  //     ),
                                  //   ),
                                  // ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                  255, 23, 59, 47)),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          onPayResult();
                                          context
                                              .read<NavigationProvider>()
                                              .selectedIndex = 2;
                                          Navigator.pushNamed(
                                              context, BottomBar.routeName);
                                        },
                                        child: const Text(
                                          "Confirm",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                  255, 23, 59, 47)),
                                        )),
                                  ],
                                );
                              })
                        },
                    },
                    child: Container(
                      margin:
                          EdgeInsets.only(right: 70.h, left: 70.h, top: 20.h),
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                          gradient: GlobalVariables.buttoncolor,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 50,
                                color: Color(0xffEEEEEE))
                          ]),
                      child: const Text(
                        'Confirm Appointment',
                        style: TextStyle(
                            color: Color.fromARGB(255, 50, 77, 65),
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
