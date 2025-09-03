import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:team1_det_tonryong/data/datasource/write_data_source.dart';
import 'package:team1_det_tonryong/data/dto/feed_dto.dart';

class WriteDataSourceImpl implements WriteDataSource {
  @override
  Future<String> createImage(XFile xFile) async {
    try {
      final storage = FirebaseStorage.instance;
      Reference ref = storage.ref();
      Reference fileRef = ref.child(
        '${DateTime.now().microsecondsSinceEpoch}_${xFile.name}',
      );
      await fileRef.putFile(File(xFile.path));
      String imageUrl = await fileRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print(e);
      return '';
    }
  }

  @override
  Future<FeedDto> createFeed({
    required String uid,
    required String feedPhoto,
    required String userNM,
  }) async {
    final firebase = FirebaseFirestore.instance;
    final colRef = firebase.collection('feeds');
    final docRef = colRef.doc();
    final now = DateTime.now();
    await docRef.set({
      'uid': uid,
      'feedPhoto': feedPhoto,
      'feedTime': now,
      'userNM': userNM,
      'fLikeUsers': [],
    });
    return FeedDto(
      feedId: docRef.id,
      userNM: userNM,
      feedTime: now,
      feedLike: 0,
      feedPhoto: feedPhoto,
      fLikeUsers: [],
    );
  }
}
