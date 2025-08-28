class UserDto {
  final String nickNM;
  final String googleUser;

  UserDto({
    required this.nickNM,
    required this.googleUser,
  });

  UserDto.fromJson(Map<String, dynamic> map)
    : this(
        nickNM: map["nickNM"],
        googleUser: map["googleUser"],
      );
  Map<String, dynamic> toJson() {
    return {
      "nickNM": nickNM,
      "googleUser": googleUser,
    };
  }
}
