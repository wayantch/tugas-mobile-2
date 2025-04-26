import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sweetique/features/product/data/models/product_model.dart';
import 'package:sweetique/features/product/domain/entities/product.dart';
import 'package:sweetique/features/product/domain/usecases/product_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductUsecaseAdd productUsecaseAdd;
  final ProductUsecaseEdit productUsecaseEdit;
  final ProductUsecaseDelete productUsecaseDelete;
  final ProductUsecaseGetAll productUsecaseGetAll;
  final ProductUsecaseGetById productUsecaseGetById;

  ProductBloc({
    required this.productUsecaseAdd,
    required this.productUsecaseEdit,
    required this.productUsecaseDelete,
    required this.productUsecaseGetAll,
    required this.productUsecaseGetById,
  }) : super(ProductInitialState()) {
    on<ProductAddEvent>((event, emit) async {
      emit(ProductLoadingState());
      final result = await productUsecaseAdd.execute(
        product: event.productModel,
      );
      result.fold(
        (failure) => emit(ProductErrorState(message: failure.toString())),
        (_) => emit(ProductSuccessState()),
      );
    });

    on<ProductEditEvent>((event, emit) async {
      emit(ProductLoadingState());
      final result = await productUsecaseEdit.execute(
        product: event.productModel,
      );
      result.fold(
        (failure) => emit(ProductErrorState(message: failure.toString())),
        (_) => emit(ProductSuccessState()),
      );
    });

    on<ProductDeleteEvent>((event, emit) async {
      emit(ProductLoadingState());
      final result = await productUsecaseDelete.execute(id: event.id);
      result.fold(
        (failure) => emit(ProductErrorState(message: failure.toString())),
        (_) => emit(ProductSuccessState()),
      );
    });

    on<ProductGetAllEvent>((event, emit) async {
      print('Ambil data semua produk...');
      emit(ProductLoadingState());
      final result = await productUsecaseGetAll.execute();
      result.fold(
        (failure) => emit(ProductErrorState(message: failure.toString())),
        (products) => emit(ProductLoadedAllState(products: products)),
      );
    });


    on<ProductGetByIdEvent>((event, emit) async {
      emit(ProductLoadingState());
      final result = await productUsecaseGetById.execute(id: event.id);
      result.fold(
        (failure) => emit(ProductErrorState(message: failure.toString())),
        (product) => emit(ProductLoadedState(product: product)),
      );
    });
  }
}
