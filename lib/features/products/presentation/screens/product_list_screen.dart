import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:product_listing_app/features/cart/presentation/bloc/cart_state.dart';
import 'package:product_listing_app/features/cart/presentation/screens/cart_screen.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<ProductBloc>().add(LoadMoreProducts());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        backgroundColor: Colors.blue,
                actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: (){
                     Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CartScreen(),
              ),
            );
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      const Icon(Icons.shopping_cart),
                      if (state.cartItems.isNotEmpty)
                        CircleAvatar(
                          radius: 8,
                          child: Text(
                            state.cartItems.length.toString(),
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search product...",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<ProductBloc>().add(SearchProducts(value));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ProductError) {
                  return Center(child: Text(state.message));
                }

                if (state is ProductLoaded) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<ProductBloc>().add(RefreshProducts());
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];

                        return ListTile(
                          leading: Image.network(product.image, width: 50),
                          title: Text(product.title),
                          subtitle: Text("\$${product.price}"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductDetailScreen(product: product),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
