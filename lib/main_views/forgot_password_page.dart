import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_owners_application_version_one/api/forgot_password_api.dart';
import '../components/common_components.dart';
import '../design_components/design_components.dart';
import 'package:home_owners_application_version_one/main_views/login_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  String email = '';
  bool isLoadingWithEmail = false;

  TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController.text = email;
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Stack(
            children: [
              const CustomWaveDesign(
                gradientColors: [Color(0xFFE6E6FA), Color(0xFF523AA8)],
              ),
              Center(
                child: SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      const SizedBox(height: 300),

                      const CustomTitleRow(title: "Home Owner\'s Application"),

                      const SizedBox(height: 25.0),
                      Column(
                        children: [
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                CommonTextFormField(
                                  controller: emailController,
                                  hintText: 'Email Address',
                                  prefixIcon: const Icon(Icons.person_outline),
                                  obscureText: false,
                                  validator: 'Enter an email address.',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18.0),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                          const SizedBox(height: 16.0),
                          Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 300,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {

                                        setState(() {
                                          isLoadingWithEmail = true;
                                        });

                                        var result = sendEmailConfirmation(emailController.text);

                                        if (result.runtimeType == String){

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
                                                            child: Center(child: Text('No User Found')),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );

                                        }

                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              25.0), // Adjust the border radius as needed
                                        ),
                                        primary: const Color(0xFF523AA8),
                                        onPrimary: const Color(
                                            0xFFE6E6FA), // Set the button color
                                      ),
                                      child: isLoadingWithEmail
                                          ? const CircularProgressIndicator(
                                        valueColor:
                                        AlwaysStoppedAnimation<
                                            Color>(
                                            Color(0xFFE6E6FA)),
                                      ) // Show loading animation
                                          : Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceAround,
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
                                                  'Send ',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors
                                                          .white))),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 16.0),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Remembered Password?',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: (){

                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration: Duration.zero, // Set the transition duration to zero
                                          pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
                                        ),
                                      );


                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        // decoration: TextDecoration.underline,
                                        color: Color(0xFF523AA8),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
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
    );
  }
}
