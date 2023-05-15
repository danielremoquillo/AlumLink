class UserDTO {
  final int id;
  final String name;
  final String email;

  const UserDTO({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      name: json['name'] as String,
      id: json['id'] as int,
      email: json['email'] as String,
    );
  }
}
