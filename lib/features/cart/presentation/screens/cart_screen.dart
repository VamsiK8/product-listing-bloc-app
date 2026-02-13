import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_state.dart';
import '../bloc/cart_event.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Cart"), backgroundColor: Colors.blue,),
      backgroundColor: Colors.white,
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {

          if (state.cartItems.isEmpty) {
            return const Center(
              child: Text("Cart is Empty"),
            );
          }

          return ListView.builder(
            itemCount: state.cartItems.length,
            itemBuilder: (context, index) {
              final product = state.cartItems[index];

              return ListTile(
                leading: Image.network(product.image, width: 50),
                title: Text(product.title),
                subtitle: Text("\$${product.price}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    context
                        .read<CartBloc>()
                        .add(RemoveFromCart(product));
                  },
                ),
              );
            },
          );
        },
      ),

    );
  }
}
