import 'package:easylifeapp/constants/global_variables.dart';
import 'package:easylifeapp/screens/registration_screen.dart';
import 'package:easylifeapp/services/auth_service.dart';
import 'package:easylifeapp/widgets/bottom_bar.dart';
import 'package:easylifeapp/widgets/custom_button.dart';
import 'package:easylifeapp/widgets/custom_textfield.dart';
import 'package:easylifeapp/widgets/password_custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  bool isHiddenPassword = true;
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() {
    authService.loginUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundcolor,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(children: [
          Container(
            height: 220.h,
            alignment: Alignment.topLeft,
            child: Image.asset('assets/appbar_circle.PNG'),
          ),
          SizedBox(
            height: 70.h,
            child: Image.asset('assets/project_logo.png'),
          ),
          Form(
            key: _loginFormKey,
            child: Column(
              children: [
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
                          fontSize: 16),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                            top: 15,
                          ),
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
                                    Icons.visibility,
                                    size: 28,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Enter your Password';
                          debugPrint('hello');
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                CustomButton(
                  text: 'Log In',
                  onTap: () {
                    if (_loginFormKey.currentState!.validate()) {
                      loginUser();
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30.h),
            alignment: Alignment.center,
            child: GestureDetector(
              child: RichText(
                text: const TextSpan(children: [
                  TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                          color: Color.fromARGB(255, 16, 94, 83),
                          fontSize: 16)),
                  TextSpan(
                      text: "Sign Up",
                      style: TextStyle(
                          color: Color.fromARGB(255, 32, 131, 118),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontSize: 16)),
                ]),
              ),
              onTap: () => {
                {Navigator.pushNamed(context, RegistrationScreen.routeName)},
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 40.h,
            ),
            alignment: Alignment.bottomCenter,
            child: const Text("About Us",
                style: TextStyle(
                    color: Color.fromARGB(255, 35, 116, 105),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontSize: 18)),
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
