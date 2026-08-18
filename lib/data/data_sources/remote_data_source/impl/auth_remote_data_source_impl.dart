import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_e_commerce_c11_online/core/error_handler.dart';
import 'package:flutter_e_commerce_c11_online/data/api_manager.dart';
import 'package:flutter_e_commerce_c11_online/data/data_sources/remote_data_source/auth_remote_data_source.dart';
import 'package:flutter_e_commerce_c11_online/data/end_points.dart';
import 'package:flutter_e_commerce_c11_online/data/model/forget_password_dto.dart';
import 'package:flutter_e_commerce_c11_online/data/model/login_response_dto.dart';
import 'package:flutter_e_commerce_c11_online/data/model/register_response_dto.dart';
import 'package:flutter_e_commerce_c11_online/data/model/reset_password_dto.dart';
import 'package:flutter_e_commerce_c11_online/data/model/verify_reset_code_dto.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/reset_password_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/verify_reset_code_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ApiManager apiManager;
  AuthRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, RegisterResponseDto>> signUp(
      {required String name,
      required String email,
      required String password,
      required String phone,
      required String rePassword}) async {
    try {
      var response = await apiManager.postData(EndPoints.register, body: {
        "name": name,
        "email": email,
        "password": password,
        "rePassword": rePassword,
        "phone": phone
      });

// هنا بنحول الريسبونس الى موديل عشان نقدر نستخدمه في الريبوزيتوري
// هنا بنحول الريسبونس الى موديل عشان نقدر نستخدمه في الريبوزيتوري
      // parsing json to model => fromJson method
      var signUpResponse = RegisterResponseDto.fromJson(response.data);
   
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right(signUpResponse);
      } else {
        return Left(
          ServerError(
            errorMessage: signUpResponse.message ?? "Server Error",
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        handleDioException(e),
      );
    } catch (e) {
      return Left(
        UnexpectedError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, LoginResponseDto>> login  ({required String email, required String password}) async{

  
  try {
      var response = await apiManager.postData(EndPoints.login, body: {
        "email": email,
        "password": password
      });
  

// هنا بنحول الريسبونس الى موديل عشان نقدر نستخدمه في الريبوزيتوري
// هنا بنحول الريسبونس الى موديل عشان نقدر نستخدمه في الريبوزيتوري
      // parsing json to model => fromJson method
      var loginResponse =  LoginResponseDto.fromJson(response.data);
   
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right(loginResponse);
      } else {
        return Left(
          ServerError(
            errorMessage: loginResponse.message ?? "Server Error",
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        handleDioException(e),
      );
    } catch (e) {
      return Left(
        UnexpectedError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, ForgetPasswordREsponseDto>> forgetPassword({required String email}) async{
  try {
      var response = await apiManager.postData(EndPoints.forgetPassword, body: {
        "email": email,
      });
      var forgetPasswordResponse =  ForgetPasswordREsponseDto.fromJson(response.data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right(forgetPasswordResponse);
      } else {
        return Left(
          ServerError(
            errorMessage: forgetPasswordResponse.message ?? "Server Error",
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        handleDioException(e),
      );
    } catch (e) {
      return Left(
        UnexpectedError(
          errorMessage: e.toString(),
        ),
      );
    }
  }


@override
Future<Either<Failures, VerifyResetCodeEntity>>
verifyResetCode({
  required String resetCode,
}) async {
  try {
    
    var response = await apiManager.postData(
      EndPoints.verifyResetCode,
      body: {
        "resetCode": resetCode,
      },
    );


    if (response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      return Right(
        VerifyResetCodeDto.fromJson(response.data),
      );
    }

    return Left(
      ServerError(
        errorMessage:
            response.data["message"] ??
            "Something went wrong",
      ),
    );
  } on DioException catch (e) {


  return Left(
    handleDioException(e),
  );
}
}
@override
Future<Either<Failures, ResetPasswordEntity>>
resetPassword({
  required String email,
  required String newPassword,
}) async {
  try {
    var response = await apiManager.putData(
      EndPoints.resetPassword,
      body: {
        "email": email,
        "newPassword": newPassword,
      },
    );

    var resetPasswordDto = ResetPasswordDto.fromJson(
      response.data,
    );

    if (response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      return Right(resetPasswordDto);
    }

    return Left(
      ServerError(
        errorMessage:
            resetPasswordDto.message ?? "Something went wrong",
      ),
    );
  } catch (e) {
    return Left(
      UnexpectedError(
        errorMessage: e.toString(),
      ),
    );
  }
}

  }
// // هنا بنحول الريسبونس الى موديل عشان نقدر نستخدمه في الريبوزيتوري
// // هنا بنحول الريسبونس الى موديل عشان نقدر نستخدمه في الريبوزيتوري
//   // parsing json to model => fromJson method 
//      var signUpResponse= RegisterResponseDto.fromJson(response.data);