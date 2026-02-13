import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:product_listing_app/features/cart/presentation/bloc/cart_event.dart';
import 'package:product_listing_app/features/cart/presentation/bloc/cart_state.dart';
import 'package:product_listing_app/features/cart/presentation/screens/cart_screen.dart';
import '../../data/models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(product.image),
            const SizedBox(height: 20),
            Text(
              product.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(product.description),
            const SizedBox(height: 10),
            Text("Price: \$${product.price}"),
            Text("Rating: ${product.rating} ⭐"),
            SizedBox(height: 10),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                final isAdded = state.isInCart(product);
                return ElevatedButton(
                  onPressed: () {
                    if (isAdded) {
                      context.read<CartBloc>().add(RemoveFromCart(product));
                    } else {
                      context.read<CartBloc>().add(AddToCart(product));
                    }
                  },
                  child: isAdded
                      ? const Text("Remove from Cart")
                      : const Text("Add to Cart"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
