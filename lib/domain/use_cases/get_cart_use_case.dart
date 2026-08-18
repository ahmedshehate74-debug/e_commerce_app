import 'package:dartz/dartz.dart';
import 'package:flutter_e_commerce_c11_online/domain/entities/cart_entity.dart';
import 'package:flutter_e_commerce_c11_online/domain/failures.dart';
import 'package:flutter_e_commerce_c11_online/domain/repository/home_repoistory.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCartUseCase {
  final HomeRepository repository;

  GetCartUseCase({
    required this.repository,
  });

  Future<Either<Failures, CartEntity>> invoke() {
    return repository.getCart();
  }
}