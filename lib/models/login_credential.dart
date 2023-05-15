class LoginCredential {
  final String email;
  final String password;

  const LoginCredential({required this.email, required this.password});

  factory LoginCredential.fromJson(Map<String, dynamic> json) {
    return LoginCredential(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }
}
