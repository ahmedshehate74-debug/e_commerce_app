// import 'package:injectable/injectable.dart';

// import '../../../api_manager.dart';
// import '../order_remote_data_source.dart';

// @Injectable(as: OrderRemoteDataSource)
// class OrderRemoteDataSourceImpl
//     implements OrderRemoteDataSource {
//   final ApiManager apiManager;

//   OrderRemoteDataSourceImpl(this.apiManager);

//  @override
// Future<void> createOrder({
//   required String cartId, 
//   required String city,
//   required String phone,
//   required String details,
// }) async {
//   print("========= CREATE ORDER =========");
//   print(cartId);

//   final response = await apiManager.postData(
//     "/orders/$cartId",
//     body: {
//       "shippingAddress": {
//         "details": details,
//         "phone": phone,
//         "city": city,
//       }
//     },
//   );

//   print("========= ORDER RESPONSE =========");
//   print(response.statusCode);
//   print(response.data);
// }
// }