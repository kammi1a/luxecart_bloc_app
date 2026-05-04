import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';
import '../widgets/category_filter.dart';
import '../widgets/hero_header.dart';
import '../widgets/product_card.dart';
import '../widgets/product_search_field.dart';
import 'product_detail_page.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('LuxeCart', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
            Text('Flutter Bloc Store', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
        actions: [
          IconButton.filledTonal(
            onPressed: () => context.read<ProductBloc>().add(const RefreshProducts()),
            icon: const Icon(Icons.refresh_rounded),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading || state is ProductInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductError) {
            return _ErrorView(message: state.message);
          }

          if (state is ProductLoaded) {
            return RefreshIndicator(
              onRefresh: () async => context.read<ProductBloc>().add(const RefreshProducts()),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: HeroHeader(totalProducts: state.products.length)),
                  SliverToBoxAdapter(
                    child: ProductSearchField(
                      onChanged: (value) => context.read<ProductBloc>().add(SearchProducts(value)),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 14)),
                  SliverToBoxAdapter(
                    child: CategoryFilter(
                      categories: state.categories,
                      selectedCategory: state.selectedCategory,
                      onSelected: (category) => context.read<ProductBloc>().add(SelectCategory(category)),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
                      child: Row(
                        children: [
                          Text(
                            '${state.visibleProducts.length} items found',
                            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                          ),
                          const Spacer(),
                          const Icon(Icons.grid_view_rounded, size: 20),
                        ],
                      ),
                    ),
                  ),
                  if (state.visibleProducts.isEmpty)
                    const SliverFillRemaining(
                      child: Center(child: Text('No products found')),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.72,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final product = state.visibleProducts[index];
                            return ProductCard(
                              product: product,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ProductDetailPage(product: product),
                                  ),
                                );
                              },
                            );
                          },
                          childCount: state.visibleProducts.length,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_rounded, size: 72),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => context.read<ProductBloc>().add(const LoadProducts()),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Try again'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
