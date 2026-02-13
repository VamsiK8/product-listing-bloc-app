import 'package:equatable/equatable.dart';
import 'package:product_listing_app/features/products/data/models/product_model.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final bool hasReachedMax;

  ProductLoaded(this.products, {this.hasReachedMax = false});

  @override
  List<Object> get props => [products, hasReachedMax];
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  List<Object> get props => [message];
}
