import 'package:alumlink_app/models/job_post_dto.dart';
import 'package:alumlink_app/widgets/job_post_card.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class JobPostService extends StatelessWidget {
  const JobPostService({super.key});

  Future<List<JobPostDTO>> fetchJobPost(http.Client client) async {
    final response = await client
        .get(Uri.parse('https://alumlink.onrender.com/api/v1/jobs'));
    // Use the compute function to run parsePhotos in a separate isolate.

    if (response.statusCode == 200) {
      List<dynamic> decodedJson = json.decode(response.body);

      return decodedJson.map((json) => JobPostDTO.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch jobs');
    }
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
