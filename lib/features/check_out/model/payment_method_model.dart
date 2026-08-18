import 'package:flutter_e_commerce_c11_online/core/resources/assets_manager.dart';


enum PaymentMethodType {
  visa,
  masterCard,
  paypal,
  applePay,
  cashOnDelivery,
}

class PaymentMethodModel {
  final String title;
  final String image;
  final PaymentMethodType type;

  const PaymentMethodModel({
    required this.title,
    required this.image,
    required this.type,
  });
}

final List<PaymentMethodModel> paymentMethods = [
  PaymentMethodModel(
    title: "Visa",
    image: ImageAssets.visaImage,
    type: PaymentMethodType.visa,
  ),
  PaymentMethodModel(
    title: "Master Card",
    image: ImageAssets.masterCardImage,
    type: PaymentMethodType.masterCard,
  ),
  PaymentMethodModel(
    title: "PayPal",
    image: ImageAssets.payPalImage,
    type: PaymentMethodType.paypal,
  ),
  PaymentMethodModel(
    title: "Apple Pay",
    image: ImageAssets.applePayImage,
    type: PaymentMethodType.applePay,
  ),
  PaymentMethodModel(
    title: "Cash On Delivery",
    image: ImageAssets.cashOnDeliveryImage,
    type: PaymentMethodType.cashOnDelivery,
  ),
];