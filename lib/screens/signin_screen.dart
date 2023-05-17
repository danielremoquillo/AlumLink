// ignore_for_file: use_build_context_synchronously

import 'package:alumlink_app/models/user.dart';
import 'package:alumlink_app/providers/session_provider.dart';
import 'package:alumlink_app/screens/main_screen.dart';
import 'package:alumlink_app/screens/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  bool _showPassword = false;
  String _errorTextEmail = '';
  String _errorTextPass = '';

  late User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserSession();
  }

  void getUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('id');
    final String? name = prefs.getString('name');
    final String? email = prefs.getString('email');
    final String? password = prefs.getString('password');

    if (id != null) {
      final User user =
          User(id: id, name: name!, email: email!, password: password!);
      print(user.name);
      //Sets up to user class inside provider
      context.read<SessionProvider>().setUser(user);

      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            return const MainScreen();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = 0.0;
            var end = 1.0;
            var curve = Curves.ease;

            var tween = Tween(begin: begin, end: end);
            var curvedAnimation =
                CurvedAnimation(parent: animation, curve: curve);

            return FadeTransition(
              opacity: tween.animate(curvedAnimation),
              child: child,
            );
          },
        ),
        (route) => false,
      );
    } else {
      print('No session found.');
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        if (_email != '' && _password != '') {
          await signInUser(_email, _password);
        }
      } catch (error) {
        print(error);
      }
    }
  }

  Future<void> setUserSession(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', user.id);
    await prefs.setString('email', user.email);
    await prefs.setString('name', user.name);
    await prefs.setString('password', user.password);

    context.read<SessionProvider>().setUser(user);
  }

  void showError(BuildContext context, String description,
      {String title = 'Signing Failed'}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //Sign In
  Future<void> signInUser(String email, String password) async {
    //Show a loading circular progress indicator which indicates the process of logging in
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      //Logging
      final response = await http.post(
        Uri.parse('https://alumlink.onrender.com/api/v1/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      //Response handler
      if (response.statusCode == 200) {
        Navigator.pop(context);
        user = User.fromJson(jsonDecode(response.body));

        //Set up session
        setUserSession(user);

        //Pushes mainscreen
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) {
              return const MainScreen();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = 0.0;
              var end = 1.0;
              var curve = Curves.ease;

              var tween = Tween(begin: begin, end: end);
              var curvedAnimation =
                  CurvedAnimation(parent: animation, curve: curve);

              return FadeTransition(
                opacity: tween.animate(curvedAnimation),
                child: child,
              );
            },
          ),
          (route) => false,
        );
      } else if (response.statusCode == 401) {
        Navigator.pop(context);
        showError(context, 'Invalid Password or Email');
      } else if (response.statusCode == 404) {
        Navigator.pop(context);

        showError(context, 'Account not exist');
      }
    } on Exception catch (e) {
      Navigator.pop(context);
      if (e.toString().contains('Failed host lookup')) {
        showError(context,
            'Unable to connect. Please check your internet connection and try again.',
            title: 'Connection Failed');
      } else {
        showError(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.09,
                bottom: 20,
                right: 40.0,
                left: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/alumlink_login_image.png',
                      scale: 4.0,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: Colors.grey[300],
                            ),

                            //Email Textfield
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon:
                                    const Icon(Icons.person_outline, size: 18),
                                labelText: 'Email',
                                contentPadding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                labelStyle: const TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFF216831)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                errorText: _errorTextEmail.isNotEmpty
                                    ? _errorTextEmail
                                    : null,
                              ),

                              // Validate if the value entered is on correct format
                              validator: (value) {
                                if (value!.isEmpty) {
                                  setState(() {
                                    _errorTextEmail = 'Please enter your email';
                                  });
                                }

                                return null;
                              },

                              //Once Submit button tapped it will save the value to _email var
                              onSaved: (value) {
                                _email = value!.toLowerCase();
                              },

                              onChanged: (value) {
                                setState(() {
                                  _errorTextEmail = '';
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: Colors.grey[300],
                            ),
                            //Password Textfield
                            child: TextFormField(
                              obscureText: !_showPassword,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock_outline_sharp,
                                  size: 16,
                                ),
                                labelText: 'Password',
                                contentPadding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                labelStyle: const TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF216831),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                errorText: _errorTextPass.isNotEmpty
                                    ? _errorTextPass
                                    : null,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                ),
                              ),

                              // Validate if the value entered is on correct format
                              validator: (value) {
                                if (value!.isEmpty) {
                                  setState(() {
                                    _errorTextPass =
                                        'Please enter your password';
                                  });
                                }

                                return null;
                              },

                              //Once Submit button tapped it will save the value to _password var
                              onSaved: (value) {
                                _password = value!;
                              },

                              onChanged: (value) {
                                setState(() {
                                  _errorTextPass = '';
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: RichText(
                              text: TextSpan(
                                text: 'Forgot Password?',
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Color(0xFF216831),
                                    fontWeight: FontWeight.w400),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          //Submit Button
                          ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF216831),
                                elevation: 0,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(14.0)))),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                ),
                RichText(
                  text: TextSpan(
                      text: "Don't have an account? ",
                      style: const TextStyle(color: Color(0xFF353535)),
                      children: [
                        TextSpan(
                            text: 'Sign Up',
                            style: const TextStyle(
                              color: Color(0xFF216831),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return const SignUpScreen();
                                    },
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = 0.0;
                                      var end = 1.0;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end);
                                      var curvedAnimation = CurvedAnimation(
                                          parent: animation, curve: curve);

                                      return FadeTransition(
                                        opacity: tween.animate(curvedAnimation),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              }),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
