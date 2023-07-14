import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_owners_application_version_one/api/auth/forgot_password_api.dart';
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
  bool emailSentSuccessfully = false;

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
              const HorizontalCustomWaveDesign(
                gradientColors: [Color(0xFFE6E6FA), Color(0xFF523AA8)],
                firstWaveHeight: 550,
                firstWaveWidth: double.infinity,
                secondWaveHeight: 350,
                secondWaveWidth: double.infinity,
              ),

              if(emailSentSuccessfully)
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 300),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF523AA8), // Rounded background color
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                        ),
                        padding: const EdgeInsets.all(20), // Padding around the container
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 80,
                            ),
                            SizedBox(height: 10), // Add some spacing between the checkmark and the text
                            Text(
                              'Email Confirmation Sent!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      CommonElevatedButton(
                        buttonText: 'Back To Login Page',
                        buttonColor: const Color(0xFF523AA8),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              if(!emailSentSuccessfully)
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
                                      onPressed: () async {


                                        setState(() {
                                          isLoadingWithEmail = true;
                                        });

                                        try {

                                          var result = await sendEmailConfirmation(emailController.text);


                                          if (result == "Password reset e-mail has been sent."){

                                            setState(() {
                                              emailSentSuccessfully = true;
                                            });
                                          } else if (result.runtimeType == String){

                                            if (!mounted) return; // Check if the widget is still mounted

                                            showDialog(
                                              context: context,
                                              builder: (builder){
                                                return CommonInfoLogDisplay(text: Text("$result"));
                                              },
                                            );
                                          }

                                        } catch (e){
                                          showDialog(
                                            context: context,
                                            builder: (builder){
                                              return CommonInfoLogDisplay(text: Text("$e"));
                                            },
                                          );

                                        } finally{
                                          setState(() {
                                            isLoadingWithEmail = false;
                                          });
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
                                                  'Send Email Confirmation',
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

                              const SizedBox(height: 16.0),

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
