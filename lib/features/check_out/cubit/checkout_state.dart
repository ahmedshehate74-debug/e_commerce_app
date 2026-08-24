import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_state.freezed.dart';

@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState.initial() = Initial;

  const factory CheckoutState.loading() = Loading;

  const factory CheckoutState.success({
    required String paymentId,
    required String paymentMethod,
    required String status,
  }) = Success;

  const factory CheckoutState.failure(
    String message,
  ) = Failure;
}