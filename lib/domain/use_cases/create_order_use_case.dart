import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../failures.dart';
import '../repository/order_repository.dart';

@injectable
class CreateOrderUseCase {
  final OrderRepository repository;

  CreateOrderUseCase(this.repository);

  Future<Either<Failures, String>> call({
    required String cartId,
  }) {
    return repository.createOrder(
      cartId: cartId,
    );
  }
}