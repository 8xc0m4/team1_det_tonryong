import 'package:team1_det_tonryong/domain/entity/detail_entity.dart';

abstract interface class DetailRepository {
  Future<DetailEntity> getDtailEntity();
}
