part of 'product_bloc.dart';

abstract class ProductState {
  const ProductState();
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<Product> visibleProducts;
  final List<String> categories;
  final String selectedCategory;
  final String query;

  const ProductLoaded({
    required this.products,
    required this.visibleProducts,
    required this.categories,
    this.selectedCategory = 'All',
    this.query = '',
  });

  ProductLoaded copyWith({
    List<Product>? products,
    List<Product>? visibleProducts,
    List<String>? categories,
    String? selectedCategory,
    String? query,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      visibleProducts: visibleProducts ?? this.visibleProducts,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      query: query ?? this.query,
    );
  }
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);
}
