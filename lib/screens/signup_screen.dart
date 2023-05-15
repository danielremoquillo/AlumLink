import 'package:alumlink_app/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _password;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  String _errorTextEmail = '';
  String _errorTextName = '';
  String _errorTextPass = '';
  String _errorTextConfirmPass = '';
  bool _isValidName = false;
  bool _isValidEmail = false;

  //Process the data
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        if (_name != '' && _email != '' && _password != '') {
          await signUpUser(_email, _name, _password);
        }
      } catch (error) {
        print(error);
      }
    }
  }

  void showResult(BuildContext context, String description,
      {String title = 'Registration Complete'}) {
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

  //Sign up
  Future<void> signUpUser(String email, String name, String password) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      final response = await http.post(
        Uri.parse('https://alumlink.onrender.com/api/v1/auth/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'name': name,
          'password': password,
        }),
      );

      //Response handler
      if (response.statusCode == 200) {
        Navigator.pop(context);
        showResult(
          context,
          'Please proceed to sign in page to continue.',
        );
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return SignInScreen();
        }), (route) => false);
      }
    } on Exception catch (e) {
      Navigator.pop(context);
      if (e.toString().contains('Failed host lookup')) {
        showResult(context,
            'Unable to connect. Please check your internet connection and try again.',
            title: 'Connection Failed');
      } else {
        showResult(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.07,
                    horizontal: 40.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: const TextSpan(
                              text: 'Sign ',
                              style: TextStyle(
                                  fontSize: 36.0,
                                  color: Color(0xFF353535),
                                  fontWeight: FontWeight.w700),
                              children: [
                                TextSpan(
                                  text: 'Up',
                                  style: TextStyle(
                                    fontSize: 36.0,
                                    color: Color(0xFF216831),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Start connecting with your alumni.',
                              style: TextStyle(fontSize: 16),
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),

                        //Sign Up Form
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor: Colors.grey[300],
                                ),

                                //Name Textfield
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    contentPadding: const EdgeInsets.only(
                                        left: 20, right: 20),
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
                                    errorText: _errorTextName.isNotEmpty
                                        ? _errorTextName
                                        : null,
                                    suffixIcon: _isValidName
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : null,
                                  ),

                                  // Validate if the value entered is on correct format
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      setState(() {
                                        _errorTextName =
                                            'Please enter your name';
                                        _isValidName = false;
                                      });
                                    }

                                    //If name has any symbol other than alphabets
                                    final RegExp nameExp =
                                        RegExp(r'^[a-zA-Z\s]+$');
                                    if (!nameExp.hasMatch(value)) {
                                      setState(() {
                                        _errorTextName =
                                            'Please enter only alphabetical characters';
                                        _isValidName = false;
                                      });
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _name = value!;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _errorTextName = '';
                                    });

                                    //Checks if the name is valid
                                    final RegExp nameExp =
                                        RegExp(r'^[a-zA-Z\s]+$');
                                    if (nameExp.hasMatch(value)) {
                                      setState(() {
                                        _isValidName = true;
                                      });
                                    } else {
                                      setState(() {
                                        _isValidName = false;
                                      });
                                    }
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

                                //Email Textfield
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    contentPadding: const EdgeInsets.only(
                                        left: 20, right: 20),
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
                                    suffixIcon: _isValidEmail
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : null,
                                  ),

                                  // Validate if the value entered is on correct format
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      setState(() {
                                        _errorTextEmail =
                                            'Please enter your email';
                                        _isValidEmail = false;
                                      });
                                    }
                                    if (!RegExp(
                                            r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                      setState(() {
                                        _errorTextEmail =
                                            'Please enter a valid email';
                                        _isValidEmail = false;
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
                                    if (RegExp(
                                            r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                      setState(() {
                                        _isValidEmail = true;
                                      });
                                    } else {
                                      setState(() {
                                        _isValidEmail = false;
                                      });
                                    }
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
                                    labelText: 'Password',
                                    contentPadding: const EdgeInsets.only(
                                        left: 20, right: 20),
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
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showPassword = !_showPassword;
                                        });
                                      },
                                    ),
                                  ),

                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      setState(() {
                                        _errorTextPass =
                                            'Please enter your password';
                                      });
                                    }

                                    return null;
                                  },

                                  onChanged: (value) {
                                    _password = value;
                                    setState(() {
                                      _errorTextPass = '';
                                    });
                                  },

                                  //Once Submit button tapped it will save the value to _password var
                                  onSaved: (value) {
                                    _password = value!;
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
                                // Confirm Password Textfield
                                child: TextFormField(
                                  obscureText: !_showConfirmPassword,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    contentPadding: const EdgeInsets.only(
                                        left: 20, right: 20),
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
                                    errorText: _errorTextConfirmPass.isNotEmpty
                                        ? _errorTextConfirmPass
                                        : null,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _showConfirmPassword
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showConfirmPassword =
                                              !_showConfirmPassword;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      setState(() {
                                        _errorTextConfirmPass =
                                            "Password doesn't match";
                                      });
                                    }
                                    if (value != _password) {
                                      setState(() {
                                        _errorTextConfirmPass =
                                            "Password doesn't match";
                                      });
                                    }

                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _errorTextConfirmPass = '';
                                    });
                                  },
                                ),
                              ),

                              const SizedBox(
                                height: 25,
                              ),

                              //Submit Button
                              ElevatedButton(
                                onPressed: _submitForm,
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF216831),
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14.0)))),
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: const Text(
                                      'Sign Up',
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
