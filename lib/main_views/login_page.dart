import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:home_owners_application_version_one/api/login_api.dart';
import 'package:home_owners_application_version_one/api/database_helper.dart';
import 'package:home_owners_application_version_one/api/google_login_api.dart';
import 'package:home_owners_application_version_one/design_components/bezier_curve.dart';
import 'package:home_owners_application_version_one/main_views/dashboard_page.dart';
import 'package:home_owners_application_version_one/models/google_users_cubit.dart';
import 'package:home_owners_application_version_one/models/google_users_model.dart';

import '../components/common_textform.dart';
import '../constants.dart';
import '../models/users_cubit.dart';
import '../models/users_model.dart';
import '../main_views/register_page.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  GoogleSignInAccount? _googleUser;

  // Future<void> _signInGoogle() async {
  //   try {
  //     GoogleSignIn googleSignIn = GoogleSignIn(
  //       scopes: [
  //         ///TODO: put scopes app will use
  //       ],
  //     );
  //     /// if previously signed in, it will signin silently
  //     /// if not, the signin dialog/login page will pop up
  //     _googleUser =
  //         await googleSignIn.signInSilently() ?? await googleSignIn.signIn();
  //
  //     print(_googleUser?.displayName);
  //     print(_googleUser?.email);
  //
  //     if (_googleUser != null) {
  //       // Successful sign-in
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => DashboardWidget(), // Replace NextPage with your desired destination page
  //         ),
  //       );
  //     } else {
  //       // Sign-in failed
  //       // Handle sign-in failure if needed
  //     }
  //
  //
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  ///sign out from google



  bool rememberMe = false;
  bool isLoadingWithEmail = false;
  bool isLoadingWithGoogle = false;


  String email = '';
  String password = '';

  int? blog_id;

  List<Map<String, dynamic>> packages = [];

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();


  Future<void> fetchPackages() async {

    final data = await DatabaseHelper.getBlogs(blog_id!);

    setState(() {
      packages = List<Map<String, dynamic>>.from(data as Iterable);
    });

  }

  void loadRememberedCredentials() async {
    final box = await Hive.openBox(rememberMeBox);
    String? storedEmail = box.get('emailController');
    String? storedPassword = box.get('passwordController');

    if (storedEmail != null && storedPassword != null) {
      setState(() {
        emailController.text = storedEmail;
        passwordController.text = storedPassword;
        rememberMe = true;
      });
    }

    box.close(); // Close the box after storing the keys

  }

  @override
  void initState() {
    super.initState();
    emailController.text = email;
    passwordController.text = password;
    loadRememberedCredentials();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
              ClipPath(
                clipper: WaveClipper(),
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
                clipper: WaveClipper2(),
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
                      const SizedBox(height: 300),
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
                                const SizedBox(height: 32.0),
                                CommonTextFormField(
                                  controller: passwordController,
                                  hintText: 'Password',
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  obscureText: true,
                                  validator: 'Enter a password.',
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 18.0),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: rememberMe,
                                    onChanged: (newValue) {
                                      setState(() {
                                        rememberMe = newValue ?? false;
                                      });
                                    },
                                    activeColor: const Color(
                                        0xFF523AA8), // Set the color of the checkbox when checked
                                  ),
                                  const Text(
                                    'Remember Me',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {

                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF523AA8)),
                                ),
                              ),
                            ],
                          ),
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

                                        googleSignOut();

                                        setState(() {
                                          isLoadingWithEmail = true;
                                        });

                                        if (formKey.currentState!.validate()){

                                          var authenticationResult = await loginUserAuth(emailController.text, passwordController.text);


                                          // if the authenticationResult in an error of some sort, it returns an
                                          // error in a form of a String
                                          if (authenticationResult.runtimeType == String){

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
                                                              child: Center(child: Text(authenticationResult)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );

                                            setState(() {
                                              isLoadingWithEmail = false;
                                            });
                                          }
                                          // if it returned the mode EmailUser, it was successful and the user will then
                                          // be pushed to the dashboard page.
                                          else if (authenticationResult.runtimeType == EmailUser){

                                            if (rememberMe == true){
                                              var box = await Hive.openBox(rememberMeBox);

                                              box.put('emailController', emailController.text);
                                              box.put('passwordController', passwordController.text);

                                              box.close(); // Close the box after storing the keys
                                            } else {
                                              var box = await Hive.openBox(rememberMeBox);

                                              box.delete('emailController');
                                              box.delete('passwordController');

                                              box.close(); // Close the box after storing the keys
                                            }

                                            EmailUser user = authenticationResult;
                                            context.read<UserCubit>().emit(user);

                                            setState(() {
                                              isLoadingWithEmail = false;
                                            });

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DashboardWidget()),
                                            );
                                          }

                                        } else {

                                          setState(() {
                                            isLoadingWithEmail = false;
                                          });

                                          return;
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
                                                        'Login with Email',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors
                                                                .white))),
                                              ],
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  const Text('Or',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black)),
                                  const SizedBox(height: 8.0),
                                  Container(
                                    width: 300,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () async {

                                        setState(() {
                                          isLoadingWithGoogle = true;
                                        });

                                        GoogleSignInAccount? googleUser = await signInGoogle();

                                        if (googleUser != null) {

                                          GoogleUser user = GoogleUser(
                                            id: googleUser.id,
                                            displayName: googleUser.displayName,
                                            email: googleUser.email,
                                            photoUrl: googleUser.photoUrl,
                                          );

                                          // context.read<GoogleUserCubit>().emit(user);


                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => DashboardWidget()));// Call the callback function to perform navigation
                                        } else {
                                          // Sign-in failed
                                          // Handle sign-in failure if needed
                                        }

                                        setState(() {
                                          isLoadingWithGoogle = false;
                                        });

                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              25.0), // Adjust the border radius as needed
                                        ),
                                        primary: Colors.grey[100],
                                        // Set the button color
                                        onPrimary: Colors
                                            .grey, // Set the button color
                                      ),
                                      child: isLoadingWithGoogle
                                          ? const CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<
                                                          Color>(
                                                      Color(0xFF523AA8)),
                                            ) // Show loading animation
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceAround,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: SvgPicture.asset(
                                                    'assets/icons/google-color-svgrepo-com.svg',
                                                    width: 30,
                                                    height: 30,
                                                  ),
                                                ),
                                                const Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        'Login with Google',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors
                                                                .black))),
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
                                    'Don\'t have an account yet?',
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
                                          pageBuilder: (context, animation, secondaryAnimation) => RegisterPage(),
                                        ),
                                      );


                                    },
                                    child: const Text(
                                      'Sign Up',
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
