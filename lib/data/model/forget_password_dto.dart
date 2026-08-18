import 'package:flutter_e_commerce_c11_online/domain/entities/forget_password_response_entity.dart';

class ForgetPasswordREsponseDto extends ForgetPasswordREsponseEntity {
 

  ForgetPasswordREsponseDto({super.statusMsg, super.message});

  ForgetPasswordREsponseDto.fromJson(Map<String, dynamic> json) {
    statusMsg = json['statusMsg'];
    message = json['message'];
  }

 
}