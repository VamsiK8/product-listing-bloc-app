import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/features/products/data/models/product_model.dart';
import 'product_event.dart';
import 'product_state.dart';
import '../../data/repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepositoryInterface repository;
  int _limit = 10;
  List<Product> _allProducts = [];

  ProductBloc(this.repository) : super(ProductInitial()) {
    on<FetchProducts>(_onFetch);
    on<RefreshProducts>(_onRefresh);
    on<LoadMoreProducts>(_onLoadMore);
    on<SearchProducts>(_onSearch);
  }

  Future<void> _onFetch(FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      _limit = 10;
      final products = await repository.fetchProducts();
      _allProducts = products;
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError("Something went wrong"));
    }
  }

  Future<void> _onRefresh(
    RefreshProducts event,
    Emitter<ProductState> emit,
  ) async {
    try {
      final products = await repository.fetchProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError("Refresh failed"));
    }
  }

  Future<void> _onLoadMore(
    LoadMoreProducts event,
    Emitter<ProductState> emit,
  ) async {
    if (state is ProductLoaded) {
      _limit += 5;

      final products = await repository.fetchProducts(limit: _limit);
      _allProducts = products;

      emit(ProductLoaded(products, hasReachedMax: products.length >= 20));
    }
  }

  void _onSearch(SearchProducts event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final filtered = _allProducts
          .where(
            (p) => p.title.toLowerCase().contains(event.query.toLowerCase()),
          )
          .toList();

      emit(ProductLoaded(filtered));
    }
  }
}
