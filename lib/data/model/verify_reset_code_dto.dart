import '../../domain/entities/verify_reset_code_entity.dart';

class VerifyResetCodeDto extends VerifyResetCodeEntity {
  VerifyResetCodeDto({
    super.status,
  });

  VerifyResetCodeDto.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }
}