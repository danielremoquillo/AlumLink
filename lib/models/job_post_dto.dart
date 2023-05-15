class JobPostDTO {
  final int id;
  final String position;
  final String location;
  final String description;
  final double salary;
  final Map<String, dynamic> user;

  const JobPostDTO({
    required this.id,
    required this.position,
    required this.location,
    required this.description,
    required this.salary,
    required this.user,
  });

  factory JobPostDTO.fromJson(Map<String, dynamic> json) {
    return JobPostDTO(
      id: json['id'] as int,
      position: json['position'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      salary: json['salary'] as double,
      user: json['user'] as Map<String, dynamic>,
    );
  }
}
