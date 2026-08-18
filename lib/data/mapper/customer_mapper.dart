import '../../domain/entities/customer_entity.dart';
import '../model/customer/customer_response_model.dart';

extension CustomerMapper on CustomerResponseModel {
  CustomerEntity toEntity() {
    return CustomerEntity(
      customerId: id ?? "",
    );
  }
}