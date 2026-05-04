import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/network/api_client.dart';
import 'core/theme/app_theme.dart';
import 'product/data/repository/product_repository.dart';
import 'product/presentation/bloc/product_bloc.dart';
import 'product/presentation/pages/product_list_page.dart';

void main() {
  final apiClient = ApiClient();
  final productRepository = ProductRepository(apiClient: apiClient);

  runApp(LuxeCartApp(productRepository: productRepository));
}

class LuxeCartApp extends StatelessWidget {
  final ProductRepository productRepository;

  const LuxeCartApp({super.key, required this.productRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: productRepository,
      child: BlocProvider(
        create: (_) => ProductBloc(repository: productRepository)..add(const LoadProducts()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'LuxeCart',
          theme: AppTheme.lightTheme(),
          home: const ProductListPage(),
        ),
      ),
    );
  }
}
