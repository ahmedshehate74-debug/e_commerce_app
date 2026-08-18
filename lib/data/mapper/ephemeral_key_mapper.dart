import '../../domain/entities/ephemeral_key_entity.dart';
import '../model/ephemeral_key/ephemeral_key_response_model.dart';

extension EphemeralKeyMapper on EphemeralKeyResponseModel {
  EphemeralKeyEntity toEntity() {
    return EphemeralKeyEntity(
      secret: secret ?? "",
    );
  }
}