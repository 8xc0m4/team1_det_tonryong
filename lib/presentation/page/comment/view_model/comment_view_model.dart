import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team1_det_tonryong/domain/entity/comment_entity.dart';
import 'package:team1_det_tonryong/presentation/providers.dart';

class CommentViewModel
    extends FamilyNotifier<List<CommentEntity>, String> {
  @override
  build(String id) {
    fetchComments(id);
    return [];
  }

  Future<void> fetchComments(String id) async {
    final getComments = ref.read(getFeedsUsecaseProvider);
    final result = await getComments.executeComment(id);
    state = result;
  }
}

final commentViewModelProvider =
    NotifierProvider.family<
      CommentViewModel,
      List<CommentEntity>,
      String
    >(
      () => CommentViewModel(),
    );
