import 'package:dartz/dartz.dart';
import 'package:sweetique/core/errors/failure.dart';
import 'package:sweetique/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
  Future<Either<Failure, ProductEntity>> getProductById({required String id});
  Future<Either<Failure, void>> addProduct({
    required ProductEntity product,
  });
  Future<Either<Failure, void>> editProduct({
    required ProductEntity product,
  });
  Future<Either<Failure, void>> deleteProduct({required String id});
}
