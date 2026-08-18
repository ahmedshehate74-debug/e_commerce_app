import 'package:flutter_e_commerce_c11_online/data/model/create_order_request_dto.dart';

import '../../domain/entities/create_order_request_entity.dart';


extension CreateOrderMapper
    on CreateOrderRequestEntity {
  CreateOrderRequestDto toDto() {
    return CreateOrderRequestDto(
      cartId: cartId,
      details: details,
      phone: phone,
      city: city,
    );
  }
}