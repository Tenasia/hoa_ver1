import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_owners_application_version_one/components/common_textform_outlined.dart';
import 'package:home_owners_application_version_one/design_components/bezier_curve.dart';
import 'package:home_owners_application_version_one/api/register_api.dart';

import '../models/users_model.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipPath(
                        clipper: HorizontalWaveClipper(),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFE6E6FA),
                                Color(0xFF523AA8),
                              ],
                            ),
                          ),
                          height: 550,
                        ),
                      ),
                      ClipPath(
                        clipper: HorizontalWaveClipper2(),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFE6E6FA),
                                Color(0xFF523AA8),
                              ],
                            ),
                          ),
                          height: 350,
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 300,
                          child: Column(
                            children: [
                              const SizedBox(height: 300.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFF523AA8), // Start color
                                          Color(0xFF523AA8), // End color
                                        ],
                                      ),
                                    ),
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Icon(
                                        Icons.house_outlined,
                                        color: Color(0xFFE6E6FA),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  const Text(
                                    'Home Owner\'s Application',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 25.0),
                              const Text('Register Account'),
                              const SizedBox(height: 15.0),
                              Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Divider(),
                                    Text('Account Information', style: TextStyle(color: Colors.grey[700]),),
                                    const SizedBox(height: 16.0),
                                    CommonTextFormFieldOutlined(
                                      controller: firstNameController,
                                      labelText: 'First Name',
                                      validator: 'First Name is Required',
                                      obscureText: false,
                                    ),
                                    const SizedBox(height: 16.0),
                                    CommonTextFormFieldOutlined(
                                      controller: middleNameController,
                                      labelText: 'Middle Name',
                                      validator: 'Middle Name is Required',
                                      obscureText: false,
                                    ),
                                    const SizedBox(height: 16.0),
                                    CommonTextFormFieldOutlined(
                                      controller: lastNameController,
                                      labelText: 'Last Name',
                                      validator: 'Last Name is Required',
                                      obscureText: false,
                                    ),
                                    const SizedBox(height: 8.0),
                                    const Divider(),
                                    const SizedBox(height: 8.0),

                                    Text('Account Credentials', style: TextStyle(color: Colors.grey[700]),),
                                    const SizedBox(height: 16.0),

                                    CommonTextFormFieldOutlined(
                                      controller: emailController,
                                      labelText: 'Email Address',
                                      validator: 'Email Address is Required',
                                      obscureText: false,
                                    ),
                                    const SizedBox(height: 16.0),
                                    CommonTextFormFieldOutlined(
                                      controller: passwordController,
                                      labelText: 'Password',
                                      validator: 'Password is Required',
                                      obscureText: true,

                                    ),
                                    const SizedBox(height: 16.0),
                                    CommonTextFormFieldOutlined(
                                      controller: confirmPasswordController,
                                      labelText: 'Confirm Password',
                                      validator: 'Confirm Password is Required',
                                      obscureText: true,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 18.0),
                              Column(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 300,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            // var registrationResult = await registerUserAuth(
                                            //   firstNameController.text,
                                            //   middleNameController.text,
                                            //   lastNameController.text,
                                            //   emailController.text,
                                            //   passwordController.text,
                                            //   confirmPasswordController.text,
                                            // );
                                            if (formKey.currentState!.validate()){

                                              setState(() {
                                                isLoading = true;
                                              });


                                              var registrationResult = await registerUserAuth(
                                                  firstNameController.text,
                                                  middleNameController.text,
                                                  lastNameController.text,
                                                  emailController.text,
                                                  passwordController.text,
                                                  confirmPasswordController.text,
                                              );

                                              if (registrationResult.runtimeType == String){

                                                showDialog(
                                                  context: context,
                                                  builder: (builder){
                                                    return Center(
                                                      child: SingleChildScrollView(
                                                        child: Dialog(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Container(
                                                                  decoration: const BoxDecoration(),
                                                                  child: Center(child: Text(registrationResult)),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              } else {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account Registered!')));
                                                Navigator.pop(context);
                                              }
                                              setState(() {
                                                isLoading = false;
                                              });
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(25.0),
                                            ),
                                            primary: const Color(0xFF523AA8),
                                            onPrimary: const Color(0xFFE6E6FA),
                                          ),
                                          child: isLoading
                                              ? const CircularProgressIndicator(
                                            valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Color(0xFFE6E6FA),
                                            ),
                                          )
                                              : Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: SvgPicture.asset(
                                                  'assets/icons/email-9-svgrepo-com.svg',
                                                  width: 30,
                                                  height: 30,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const Expanded(
                                                flex: 3,
                                                child: Text(
                                                  'Register Account',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have an account?',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Log In',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF523AA8),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 18.0),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
