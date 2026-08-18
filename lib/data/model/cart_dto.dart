import 'package:flutter_e_commerce_c11_online/domain/entities/cart_entity.dart';

class CartDto {
  final String cartId;
  final List<CartProductDto> products;
  final int totalCartPrice;
  final int numOfCartItems;

  CartDto({
    required this.cartId,
    required this.products,
    required this.totalCartPrice,
    required this.numOfCartItems,
  });

  factory CartDto.fromJson(Map<String, dynamic> json) {
  print("========== CART JSON ==========");
  print(json);

  return CartDto(
    cartId: json["cartId"],
    products: (json["data"]["products"] as List)
        .map((e) => CartProductDto.fromJson(e))
        .toList(),
    totalCartPrice: json["data"]["totalCartPrice"],
    numOfCartItems: json["numOfCartItems"],
  );
}

  CartEntity toEntity() {
    return CartEntity(
      cartId: cartId,
      products: products.map((e) => e.toEntity()).toList(),
      totalCartPrice: totalCartPrice,
      numOfCartItems: numOfCartItems,
    );
  }
}

class CartProductDto {
  final String cartItemId;
  final String id;
  final String title;
  final String image;
  final int price;
  final int count;

  CartProductDto({
    required this.cartItemId,
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.count,
  });

  factory CartProductDto.fromJson(Map<String, dynamic> json) {
    return CartProductDto(
      cartItemId: json["_id"],
      id: json["product"]["_id"],
      title: json["product"]["title"],
      image: json["product"]["imageCover"],
      price: json["price"],
      count: json["count"],
    );
  }

  CartProductEntity toEntity() {
    return CartProductEntity(
      cartItemId: cartItemId,
      id: id,
      title: title,
      image: image,
      price: price,
      count: count,
    );
  }
}