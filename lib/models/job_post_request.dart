class JobPostRequest {
  final int user_id;
  final String position;
  final String location;
  final String description;
  final double salary;

  const JobPostRequest({
    required this.user_id,
    required this.position,
    required this.location,
    required this.description,
    required this.salary,
  });

  factory JobPostRequest.fromJson(Map<String, dynamic> json) {
    return JobPostRequest(
      user_id: json['user_id'] as int,
      position: json['position'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      salary: json['salary'] as double,
    );
  }
}
