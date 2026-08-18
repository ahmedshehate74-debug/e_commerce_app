import 'package:dartz/dartz.dart';

import '../entities/customer_entity.dart';
import '../failures.dart';
import '../repository/checkout_repository.dart';
 import 'package:injectable/injectable.dart';

@injectable
class CreateCustomerUseCase {
  final CheckoutRepository repository;

  CreateCustomerUseCase(this.repository);

  Future<Either<Failures, CustomerEntity>> call() {
    return repository.createCustomer();
  }
}