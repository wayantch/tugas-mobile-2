part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductInitialState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductErrorState extends ProductState {
  final String message;

  const ProductErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProductLoadedAllState extends ProductState {
  final List<ProductEntity> products;

  const ProductLoadedAllState({required this.products});

  @override
  List<Object?> get props => [products];
}

class ProductLoadedState extends ProductState {
  final ProductEntity product;

  const ProductLoadedState({required this.product});

  @override
  List<Object?> get props => [product];
}

class ProductSuccessState extends ProductState {
  @override
  List<Object?> get props => [];
}
