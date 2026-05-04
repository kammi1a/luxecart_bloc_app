part of 'product_bloc.dart';

abstract class ProductEvent {
  const ProductEvent();
}

class LoadProducts extends ProductEvent {
  const LoadProducts();
}

class RefreshProducts extends ProductEvent {
  const RefreshProducts();
}

class SearchProducts extends ProductEvent {
  final String query;

  const SearchProducts(this.query);
}

class SelectCategory extends ProductEvent {
  final String category;

  const SelectCategory(this.category);
}
