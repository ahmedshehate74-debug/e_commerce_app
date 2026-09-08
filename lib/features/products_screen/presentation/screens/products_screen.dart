import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/home/cubit/product_state.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/home/cubit/products_cubit.dart';

import '../../../../core/resources/values_manager.dart';
import '../../../../core/widget/home_screen_app_bar.dart';
import '../../widgets/custom_product_widget.dart';

class ProductsScreen extends StatefulWidget {
  final String? subCategoryId;

  const ProductsScreen({
    super.key,
    this.subCategoryId,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late ScrollController scrollController;

  @override

  void initState() {

    super.initState();

    scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("ProductsScreen => ${widget.subCategoryId}");
      context.read<ProductsCubit>().getProducts(
            subCategoryId: widget.subCategoryId,
          );
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        context.read<ProductsCubit>().loadMoreProducts();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: const HomeScreenAppBar(
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: BlocBuilder<ProductsCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ProductError) {
              return Center(
                child: Text(state.failures.errorMessage),
              );
            }

            if (state is ProductSuccess) {
              return GridView.builder(
                controller: scrollController,
                itemCount: state.products.length + (state.hasMore ? 1 : 0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.62,
                ),
                itemBuilder: (context, index) {
                  if (index == state.products.length) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final product = state.products[index];

                  return CustomProductWidget(
                    width: width,
                    height: height,
                    image: product.image,
                    title: product.title,
                    description: product.description,
                    price: product.price,
                    priceAfterDiscount: product.priceAfterDiscount,
                    rating: product.rating,
                    id: product.id,
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import '../../../../core/resources/assets_manager.dart';
// import '../../../../core/resources/values_manager.dart';
// import '../../../../core/widget/home_screen_app_bar.dart';
// import '../widgets/custom_product_widget.dart';

// class ProductsScreen extends StatelessWidget {
//   const ProductsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: const HomeScreenAppBar(
//         automaticallyImplyLeading: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(AppPadding.p16),
//         child: Column(
//           children: [
//             Expanded(
//               child: GridView.builder(
//                 itemCount: 20,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 8,
//                   mainAxisSpacing: 8,
//                   childAspectRatio: 7 / 9,
//                 ),
//                 itemBuilder: (context, index) {
//                   return CustomProductWidget(
//                     image: ImageAssets.categoryHomeImage,
//                     title: "Nike Air Jordon",
//                     price: 1100,
//                     rating: 4.7,
//                     discountPercentage: 10,
//                     height: height,
//                     width: width,
//                     description:
//                         "Nike is a multinational corporation that designs, develops, and sells athletic footwear ,apparel, and accessories",
//                   );
//                 },
//                 scrollDirection: Axis.vertical,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
