import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_c11_online/domain/use_cases/get_all_products_use_case.dart';
import 'package:flutter_e_commerce_c11_online/features/main_layout/home/cubit/product_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/produect_entity.dart';

@injectable
class ProductsCubit extends Cubit<ProductState> {
  final GetAllProductsUseCase getAllProductsUseCase;

  ProductsCubit(this.getAllProductsUseCase) : super(ProductInitial());

  /// كل المنتجات اللي هتتعرض في الـ UI
  List<ProductEntity> products = [];

  /// الصفحة الحالية
  int currentPage = 1;

  /// هل فيه صفحات تانية؟
  bool hasMore = true;

  /// هل أنا بجيب صفحة جديدة دلوقتي؟
  bool isLoadingMore = false;

  String? currentSubCategoryId;

  /// أول تحميل للشاشة
  Future<void> getProducts({
    String? subCategoryId,
  }) async {
    emit(ProductLoading());
       currentSubCategoryId = subCategoryId;
    currentPage = 1;
    hasMore = true;
    products.clear();
    
print("SUB CATEGORY ID = $currentSubCategoryId");
    final result = await getAllProductsUseCase(
      page: currentPage,
      subCategoryId: currentSubCategoryId,
    );
    result.fold(
      (failure) {
        emit(ProductError(failure));
      },
      (pageEntity) {
        products = pageEntity.products;

        currentPage++;

        hasMore = pageEntity.hasMore;

        emit(
          ProductSuccess(
            products: products,
            hasMore: hasMore,
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  /// تحميل الصفحة اللي بعدها
  Future<void> loadMoreProducts() async {
    if (!hasMore || isLoadingMore) return;

    isLoadingMore = true;

    emit(
      ProductSuccess(
        products: products,
        hasMore: hasMore,
        isLoadingMore: true,
      ),
    );

    final result = await getAllProductsUseCase(
  page: currentPage,
  subCategoryId: currentSubCategoryId,
);

    result.fold(
      (failure) {
        isLoadingMore = false;

        emit(ProductError(failure));
      },
      (pageEntity) {
        products.addAll(pageEntity.products);

        currentPage++;

        hasMore = pageEntity.hasMore;

        isLoadingMore = false;

        emit(
          ProductSuccess(
            products: products,
            hasMore: hasMore,
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  void refreshFavouriteIds() {
    emit(
      ProductSuccess(
        products: List.from(products),
        hasMore: hasMore,
        isLoadingMore: isLoadingMore,
      ),
    );
  }
}



// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_e_commerce_c11_online/domain/use_cases/get_all_products_use_case.dart';
// import 'package:flutter_e_commerce_c11_online/features/main_layout/brand/cubit/product_state.dart';
// import 'package:injectable/injectable.dart';

// import '../../../../domain/entities/produect_entity.dart';


// @injectable
// class ProductsCubit extends Cubit<ProductState> {
//   final GetAllProductsUseCase getAllProductsUseCase;

//   ProductsCubit(this.getAllProductsUseCase)
//       : super(ProductInitial());

//   List<ProductEntity> products = [];

//   int currentPage = 1;

//   bool hasMore = true;

//   bool isLoadingMore = false;

//   Future<void> getProducts() async {
//     emit(ProductLoading());

//     currentPage = 1;
//     hasMore = true;
//     products.clear();

//     final result = await getAllProductsUseCase(
//       page: currentPage,
//     );

//     result.fold(
//       (failure) {
//         emit(ProductError(failures: failure) ));
//       },
//       (pageEntity) {
//         products = pageEntity.products;

//         currentPage++;

//         hasMore = pageEntity.hasMore;

//         emit(
//           ProductSuccess(
//             products: products,
//             hasMore: hasMore,
//             isLoadingMore: false,
//           ),
//         );
//       },
//     );
//   }

//   Future<void> loadMoreProducts() async {
//     if (!hasMore || isLoadingMore) return;

//     isLoadingMore = true;

//     emit(
//       ProductSuccess(
//         products: products,
//         hasMore: hasMore,
//         isLoadingMore: true,
//       ),
//     );

//     final result = await getAllProductsUseCase(
//       page: currentPage,
//     );

//     result.fold(
//       (failure) {
//         isLoadingMore = false;

//         emit(ProductError(failure));
//       },
//       (pageEntity) {
//         products.addAll(pageEntity.products);

//         currentPage++;

//         hasMore = pageEntity.hasMore;

//         isLoadingMore = false;

//         emit(
//           ProductSuccess(
//             products: products,
//             hasMore: hasMore,
//             isLoadingMore: false,
//           ),
//         );
//       },
//     );
//   }
// }