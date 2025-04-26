import 'package:dartz/dartz.dart';
import 'package:sweetique/core/errors/failure.dart';
import 'package:sweetique/features/product/data/datasources/product_datasource.dart';
import 'package:sweetique/features/product/data/models/product_model.dart';
import 'package:sweetique/features/product/domain/entities/product.dart';
import 'package:sweetique/features/product/domain/repositories/product_repository.dart';

class ProductRepoImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepoImpl({required this.productRemoteDataSource});

  @override
  Future<Either<Failure, void>> addProduct({
    required ProductEntity product,
  }) async {
    try {
      final productModel = ProductModel(
        id: product.id,
        nameProduct: product.nameProduct,
        price: product.price,
        description: product.description,
        categoryId: product.categoryId,
        typeId: product.typeId,
        warehouseId: product.warehouseId,
        createdAt: product.createdAt,
        updatedAt: product.updatedAt,
      );
      await productRemoteDataSource.addProduct(product: productModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, void>> deleteProduct({required String id}) async {
    try {
      await productRemoteDataSource.deleteProduct(id: id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editProduct({
    required ProductEntity product,
  }) async {
    try {
      final productModel = ProductModel(
        id: product.id,
        nameProduct: product.nameProduct,
        price: product.price,
        description: product.description,
        categoryId: product.categoryId,
        typeId: product.typeId,
        warehouseId: product.warehouseId,
        createdAt: product.createdAt,
        updatedAt: product.updatedAt,
      );
      await productRemoteDataSource.editProduct(product: productModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    try {
      final data = await productRemoteDataSource.getAllProducts();
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById({
    required String id,
  }) async {
    try {
      final data = await productRemoteDataSource.getProductById(id: id);
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
