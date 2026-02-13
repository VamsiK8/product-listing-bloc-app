import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import '../../../products/data/models/product_model.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState([])) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    if (!state.cartItems.any((p) => p.id == event.product.id)) {
      final updated = List<Product>.from(state.cartItems)..add(event.product);
      emit(CartState(updated));
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updated = List<Product>.from(state.cartItems)..remove(event.product);
    emit(CartState(updated));
  }
}
