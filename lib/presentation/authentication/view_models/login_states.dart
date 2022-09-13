class LoginStates {
  final bool obscurePassword;

  LoginStates({
    required this.obscurePassword,
  });

  factory LoginStates.init() {
    return LoginStates(obscurePassword: true);
  }

  LoginStates copyWith({bool? obscurePassword}) {
    return LoginStates(
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}
