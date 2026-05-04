import 'package:bloc/bloc.dart';

import '../../data/model/product.dart';
import '../../data/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(const ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<RefreshProducts>(_onRefreshProducts);
    on<SearchProducts>(_onSearchProducts);
    on<SelectCategory>(_onSelectCategory);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());
    await _fetchAndEmit(emit);
  }

  Future<void> _onRefreshProducts(
    RefreshProducts event,
    Emitter<ProductState> emit,
  ) async {
    await _fetchAndEmit(emit);
  }

  Future<void> _fetchAndEmit(Emitter<ProductState> emit) async {
    try {
      final products = await repository.fetchProducts();
      final categories = _buildCategories(products);
      emit(ProductLoaded(
        products: products,
        visibleProducts: products,
        categories: categories,
      ));
    } catch (_) {
      emit(const ProductError('Could not load products. Check your internet connection and try again.'));
    }
  }

  void _onSearchProducts(SearchProducts event, Emitter<ProductState> emit) {
    final current = state;
    if (current is ProductLoaded) {
      final filtered = _filterProducts(
        products: current.products,
        query: event.query,
        category: current.selectedCategory,
      );
      emit(current.copyWith(visibleProducts: filtered, query: event.query));
    }
  }

  void _onSelectCategory(SelectCategory event, Emitter<ProductState> emit) {
    final current = state;
    if (current is ProductLoaded) {
      final filtered = _filterProducts(
        products: current.products,
        query: current.query,
        category: event.category,
      );
      emit(current.copyWith(
        selectedCategory: event.category,
        visibleProducts: filtered,
      ));
    }
  }

  List<String> _buildCategories(List<Product> products) {
    final values = products.map((product) => product.shortCategory).toSet().toList()..sort();
    return ['All', ...values];
  }

  List<Product> _filterProducts({
    required List<Product> products,
    required String query,
    required String category,
  }) {
    final normalizedQuery = query.toLowerCase().trim();
    final normalizedCategory = category.toLowerCase().trim();

    return products.where((product) {
      final categoryMatches = normalizedCategory == 'all' ||
          product.shortCategory.toLowerCase() == normalizedCategory;
      final queryMatches = normalizedQuery.isEmpty ||
          product.title.toLowerCase().contains(normalizedQuery) ||
          product.brand.toLowerCase().contains(normalizedQuery) ||
          product.shortCategory.toLowerCase().contains(normalizedQuery);
      return categoryMatches && queryMatches;
    }).toList();
  }
}
