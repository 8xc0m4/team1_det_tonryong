class UserDto {
  final String nickNM;
  final String uid;

  UserDto({
    required this.nickNM,
    required this.uid,
  });

  UserDto.fromJson(Map<String, dynamic> map)
    : this(
        nickNM: map["nickNM"],
        uid: map["uid"],
      );

  Map<String, dynamic> toJson() {
    return {
      "nickNM": nickNM,
      "uid": uid,
    };
  }
}
