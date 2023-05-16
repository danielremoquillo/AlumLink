// ignore_for_file: use_build_context_synchronously

import 'package:alumlink_app/providers/session_provider.dart';
import 'package:alumlink_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class JobPostRequestScreen extends StatefulWidget {
  const JobPostRequestScreen({super.key});

  @override
  State<JobPostRequestScreen> createState() => _JobPostRequestScreenState();
}

class _JobPostRequestScreenState extends State<JobPostRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _position;
  late String _location;
  late String _description;
  late double _salary;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        if (_position != '' &&
            _location != '' &&
            _description != '' &&
            !_salary.isNaN) {
          await postJob(_position, _location, _description, _salary);
        }
      } catch (error) {
        print(error);
      }
    }
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
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  //Sign In
  Future<void> postJob(String position, String location, String description,
      double salary) async {
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
        Uri.parse('https://alumlink.onrender.com/api/v1/jobs'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "position": _position,
          "location": _location,
          "description": _description,
          "salary": _salary,
          "user_id":
              Provider.of<SessionProvider>(context, listen: false).user.id,
        }),
      );

      //Response handler
      if (response.statusCode == 201) {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) {
              return const MainScreen();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(0.0, -1.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween = Tween(begin: begin, end: end);
              var curvedAnimation =
                  CurvedAnimation(parent: animation, curve: curve);

              return SlideTransition(
                position: tween.animate(curvedAnimation),
                child: child,
              );
            },
          ),
          // Specify the condition to remove the previous routes from the stack.
          (route) => false, // Remove all routes except the new route.
        );
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Post a Job',
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Color(0xFF216831),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Details',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextField(
                          style: const TextStyle(
                            fontSize: 13.0,
                          ),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 11),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintText: 'Position',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _position = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: const TextStyle(
                            fontSize: 13.0,
                          ),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 11),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintText: 'Location',
                            prefixIcon: Icon(Icons.location_on_outlined),
                          ),
                          onChanged: (value) {
                            // Perform search operation here
                            setState(() {
                              _location = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: const TextStyle(
                            fontSize: 13.0,
                          ),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 11),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintText: 'Description',
                            prefixIcon: Icon(Icons.description_outlined),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _description = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 13.0,
                          ),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 11),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintText: 'Salary',
                            prefixIcon: Icon(Icons.attach_money_outlined),
                          ),
                          onChanged: (value) {
                            setState(() {
                              try {
                                _salary = double.tryParse(value)!;
                              } on Exception catch (_) {
                                _salary = 0;
                              }
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  //Submit Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF216831),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0.0)))),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: const Text(
                            'Post',
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.center,
                          )),
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
