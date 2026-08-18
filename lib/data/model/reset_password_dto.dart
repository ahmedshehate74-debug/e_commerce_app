import '../../domain/entities/reset_password_entity.dart';

class ResetPasswordDto extends ResetPasswordEntity {
  ResetPasswordDto({
    super.token,
    super.statusMsg,
    super.message,
  });

  factory ResetPasswordDto.fromJson(
    Map<String, dynamic> json,
  ) {
    return ResetPasswordDto(
      token: json["token"],
      statusMsg: json["statusMsg"],
      message: json["message"],
    );
  }
}