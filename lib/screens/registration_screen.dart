import 'package:easylifeapp/screens/about_us_screen.dart';
import 'package:easylifeapp/screens/login_screen.dart';
import 'package:easylifeapp/screens/terms_condition_screen.dart';
import 'package:easylifeapp/services/auth_service.dart';
import 'package:easylifeapp/widgets/custom_textfield.dart';
import 'package:easylifeapp/widgets/number_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/global_variables.dart';
import '../widgets/custom_button.dart';

enum Type {
  customer,
  serviceman,
}

class RegistrationScreen extends StatefulWidget {
  static const String routeName = '/registration-screen';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _registerFormKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool isHiddenPassword = true;
  final AuthService authService = AuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  String type = 'Customer';
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phonenumberController.dispose();
  }

  List<String> userType = [
    'Customer',
    'Serviceman',
  ];

  void registerUser() {
    authService.registerUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      phone: _phonenumberController.text,
      type: type,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundcolor,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: SizedBox(
              height: 70.h,
              child: Image.asset('assets/project_logo.png'),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            alignment: Alignment.center,
            child: const Text("Welcome On Board! ",
                style: TextStyle(
                    color: Color.fromARGB(255, 18, 116, 102),
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: const Text("Best living experience with EasyLife.com",
                style: TextStyle(
                    color: Color.fromARGB(255, 32, 131, 118),
                    fontWeight: FontWeight.bold,
                    fontSize: 17)),
          ),
          Form(
            key: _registerFormKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _nameController,
                  hintText: 'Full Name',
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  icon: const Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 15.h, right: 15.h, top: 20.h),
                  padding: EdgeInsets.only(left: 20.h, right: 20.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: const Color.fromARGB(255, 76, 173, 160),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color.fromARGB(255, 255, 255, 255),
                        )
                      ]),
                  child: Theme(
                    data: ThemeData(errorColor: Colors.white),
                    child: TextFormField(
                      controller: _passwordController,
                      cursorColor: Colors.white,
                      obscureText: isHiddenPassword,
                      keyboardType: TextInputType.visiblePassword,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(top: 15, right: 5),
                          hintStyle: const TextStyle(color: Colors.white),
                          hintText: 'Password',
                          icon: const Icon(
                            Icons.vpn_key,
                            size: 28,
                            color: Colors.white,
                          ),
                          suffixIcon: InkWell(
                            onTap: _togglePasswordView,
                            child: isHiddenPassword
                                ? const Icon(
                                    Icons.visibility_off,
                                    size: 28,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                  ),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Enter your Password';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                NumberCustomTextField(
                  controller: _phonenumberController,
                  hintText: 'Mobile Number',
                  icon: const Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 15),
                  height: 50,
                  width: 360,
                  child: const Text(
                    'User type?',
                    style: TextStyle(
                        color: Color.fromARGB(255, 79, 110, 100),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: 330,
                  child: DropdownButton(
                    value: type,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: userType.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 54, 83, 73),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        type = newVal!;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Checkbox(
                          checkColor: Colors.white,
                          activeColor: const Color.fromARGB(255, 32, 131, 118),
                          value: isChecked,
                          onChanged: (bool? newValue) {
                            setState(() {
                              isChecked = newValue!;
                            });
                          }),
                    ),
                    GestureDetector(
                      onTap: () => {
                        {
                          {
                            Navigator.pushNamed(
                                context, TermsAndConditionPage.routeName),
                          }
                        }
                      },
                      child: RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                              text: "I hereby agree to the ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 16, 94, 83),
                                  fontSize: 15)),
                          TextSpan(
                              text: "Terms and Conditions",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 32, 131, 118),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 2,
                                  fontSize: 15)),
                        ]),
                      ),
                    ),
                  ],
                ),
                CustomButton(
                    text: 'Register',
                    onTap: () {
                      if (_registerFormKey.currentState!.validate()) {
                        registerUser();
                      }
                      if (isChecked) {
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "You need to agree terms and conditions before registering account.",
                            ),
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30.h, bottom: 30.h),
            alignment: Alignment.center,
            child: GestureDetector(
              child: RichText(
                text: const TextSpan(children: [
                  TextSpan(
                      text: "Have an account? ",
                      style: TextStyle(
                          color: Color.fromARGB(255, 16, 94, 83),
                          fontSize: 16)),
                  TextSpan(
                      text: "Log In",
                      style: TextStyle(
                          color: Color.fromARGB(255, 32, 131, 118),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2,
                          fontSize: 16)),
                ]),
              ),
              onTap: () =>
                  {Navigator.pushNamed(context, LoginScreen.routeName)},
            ),
          ),
        ]),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
}
