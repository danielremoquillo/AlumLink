import 'package:alumlink_app/models/job_post_dto.dart';
import 'package:alumlink_app/widgets/job_post_card.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class JobPostService extends StatefulWidget {
  const JobPostService({super.key});

  @override
  State<JobPostService> createState() => _JobPostServiceState();
}

class _JobPostServiceState extends State<JobPostService> {
  Future<List<JobPostDTO>> fetchJobPost(http.Client client) async {
    try {
      final response = await client
          .get(Uri.parse('https://alumlink.onrender.com/api/v1/jobs'));
      // Use the compute function to run parsePhotos in a separate isolate.

      if (response.statusCode == 200) {
        List<dynamic> decodedJson = json.decode(response.body);

        return decodedJson.map((json) => JobPostDTO.fromJson(json)).toList();
      }
    } on Exception catch (e) {
      if (e.toString().contains('Failed host lookup')) {
        showError(context,
            'Unable to connect. Please check your internet connection and try again.',
            title: 'Connection Failed');
      } else {
        showError(context, e.toString());
      }
    }
    return [];
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<List<JobPostDTO>>(
          future: fetchJobPost(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error!}'),
              );
            } else if (snapshot.hasData) {
              List<Widget> jobList = snapshot.data!
                  .map((jobPostDTO) => JobPostCard(jobPostDTO: jobPostDTO))
                  .toList();
              return Column(children: <Widget>[
                ...jobList, // Note the three dots before the widgetList
              ]);
            } else if (snapshot.hasError) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: const Center(
                  child: Text('Failed to fetch jobs'),
                ),
              );
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}
