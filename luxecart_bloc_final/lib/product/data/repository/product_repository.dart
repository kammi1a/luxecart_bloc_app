import '../../../core/network/api_client.dart';
import '../model/product.dart';

class ProductRepository {
  final ApiClient apiClient;

  const ProductRepository({required this.apiClient});

  Future<List<Product>> fetchProducts() async {
    final data = await apiClient.getProducts();
    final productsJson = data['products'] as List<dynamic>;

    return productsJson
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
