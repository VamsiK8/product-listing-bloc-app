import 'package:equatable/equatable.dart';
import '../../../products/data/models/product_model.dart';

class CartState extends Equatable {
  final List<Product> cartItems;

  const CartState(this.cartItems);

  bool isInCart(Product product) {
    return cartItems.any((item) => item.id == product.id);
  }

  @override
  List<Object> get props => [cartItems];
}
