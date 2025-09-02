import 'package:image_picker/image_picker.dart';
import 'package:team1_det_tonryong/data/dto/feed_dto.dart';

abstract interface class WriteDataSource {
  Future<String> createImage(XFile xFile);
  Future<FeedDto> createFeed({required String uid,required String feedPhoto,required String userNM});
}
