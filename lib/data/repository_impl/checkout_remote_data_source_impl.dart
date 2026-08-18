import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/error_handler.dart';

import '../data_sources/remote_data_source/checkout_remote_data_source.dart';

import '../mapper/customer_mapper.dart';
import '../mapper/ephemeral_key_mapper.dart';
import '../mapper/payment_intent_mapper.dart';

import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/ephemeral_key_entity.dart';
import '../../domain/entities/create_payment_intent_request_entity.dart';
import '../../domain/entities/create_payment_intent_response_entity.dart';

import '../../domain/failures.dart';
import '../../domain/repository/checkout_repository.dart';

@Injectable(as: CheckoutRepository)
class CheckoutRepositoryImpl
    implements CheckoutRepository {

  final CheckoutRemoteDataSource remoteDataSource;

  CheckoutRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, CustomerEntity>>
      createCustomer() async {
    try {
      final response =
          await remoteDataSource.createCustomer();

      return Right(response.toEntity());
    } on DioException catch (e) {
      return Left(handleDioException(e));
    } catch (e) {
      return Left(
        UnexpectedError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, EphemeralKeyEntity>>
      createEphemeralKey(
          String customerId) async {
    try {
      final response =
          await remoteDataSource
              .createEphemeralKey(customerId);

      return Right(response.toEntity());
    } on DioException catch (e) {
      return Left(handleDioException(e));
    } catch (e) {
      return Left(
        UnexpectedError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<
      Either<
          Failures,
          CreatePaymentIntentResponseEntity>>
      createPaymentIntent(
    CreatePaymentIntentRequestEntity request,
  ) async {
    try {
      final response =
          await remoteDataSource
              .createPaymentIntent(
                  request.toDto());

      return Right(response.toEntity());
    } on DioException catch (e) {
      return Left(handleDioException(e));
    } catch (e) {
      return Left(
        UnexpectedError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}