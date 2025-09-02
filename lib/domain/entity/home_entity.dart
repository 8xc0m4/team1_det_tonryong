class HomeEntity {
  String feedPhoto;
  String feedId;
  DateTime feedTime;
  List<String> fLikeUsers;

  HomeEntity({
    required this.feedPhoto,
    required this.feedId,
    required this.feedTime,
    required this.fLikeUsers,
  });
}
