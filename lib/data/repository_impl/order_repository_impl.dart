import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/failures.dart';
import '../../domain/repository/order_repository.dart';
import '../data_sources/remote_data_source/order_remote_data_source.dart';

@Injectable(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remote;

  OrderRepositoryImpl(this.remote);

  @override
  Future<Either<Failures, String>> createOrder({
    required String cartId,
  }) async {
    try {
      await remote.createOrder(
        cartId: cartId,
        city: "Zagazig",
        phone: "01000000000",
        details: "Home",
      );

      return const Right("Success");
    } catch (e) {
      return Left(
        UnexpectedError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}