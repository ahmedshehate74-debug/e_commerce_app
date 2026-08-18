import 'package:flutter_e_commerce_c11_online/domain/entities/brand_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';

abstract class BrandState {}

class BrandInitial extends BrandState {}

class BrandLoading extends BrandState {}

class BrandSuccess extends BrandState {
  final List<BrandEntity> brands;

  BrandSuccess({required this.brands});
}

class BrandError extends BrandState {
  final Failures failures;

  BrandError({required this.failures});
}