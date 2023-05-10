import 'package:alumlink_app/screens/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Do something with the form data, such as submitting it to a server
      //   Navigator.pushAndRemoveUntil(context,
      //       MaterialPageRoute(builder: (context) {

      //   }), (route) => false);
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
                                if (!RegExp(
                                        r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  setState(() {
                                    _errorTextEmail =
                                        'Please enter a valid email';
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
