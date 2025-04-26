part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class ProductAddEvent extends ProductEvent {
  final ProductModel productModel;

  const ProductAddEvent({required this.productModel});

  @override
  List<Object?> get props => [productModel];
}

class ProductEditEvent extends ProductEvent {
  final ProductModel productModel;

  const ProductEditEvent({required this.productModel});

  @override
  List<Object?> get props => [productModel];
}

class ProductDeleteEvent extends ProductEvent {
  final String id;

  const ProductDeleteEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class ProductGetAllEvent extends ProductEvent {
  const ProductGetAllEvent();

  @override
  List<Object?> get props => [];
}

class ProductGetByIdEvent extends ProductEvent {
  final String id;

  const ProductGetByIdEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
