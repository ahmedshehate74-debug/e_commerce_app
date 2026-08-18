class CartEntity {
  final String cartId;
  final List<CartProductEntity> products;
  final int totalCartPrice;
  final int numOfCartItems;

  CartEntity({
    required this.cartId,
    required this.products,
    required this.totalCartPrice,
    required this.numOfCartItems,
  });
}

class CartProductEntity {
  final String cartItemId;
  final String id;
  final String title;
  final String image;
  final int price;
  final int count;

  CartProductEntity({
    required this.cartItemId,
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.count,
  });
}