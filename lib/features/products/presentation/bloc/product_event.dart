import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {}

class RefreshProducts extends ProductEvent {}

class LoadMoreProducts extends ProductEvent {}

class SearchProducts extends ProductEvent {
  final String query;

  SearchProducts(this.query);

  @override
  List<Object> get props => [query];
}
