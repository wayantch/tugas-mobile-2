import 'package:dartz/dartz.dart';
import 'package:sweetique/core/errors/failure.dart';
import 'package:sweetique/features/product/domain/entities/product.dart';
import 'package:sweetique/features/product/domain/repositories/product_repository.dart';

class ProductUsecaseGetAll {
  final ProductRepository productRepository;

  ProductUsecaseGetAll({required this.productRepository});

  Future<Either<Failure, List<ProductEntity>>> execute() async {
    return await productRepository.getAllProducts();
  }
}

class ProductUsecaseGetById {
  final ProductRepository productRepository;

  ProductUsecaseGetById({required this.productRepository});

  Future<Either<Failure, ProductEntity>> execute({required String id}) async {
    return await productRepository.getProductById(id: id);
  }
}

class ProductUsecaseAdd {
  final ProductRepository productRepository;

  ProductUsecaseAdd({required this.productRepository});

  Future<Either<Failure, void>> execute({
    required ProductEntity product,
  }) async {
    return await productRepository.addProduct(product: product);
  }
}

class ProductUsecaseEdit {
  final ProductRepository productRepository;

  ProductUsecaseEdit({required this.productRepository});

  Future<Either<Failure, void>> execute({
    required ProductEntity product,
  }) async {
    return await productRepository.editProduct(product: product);
  }
}

class ProductUsecaseDelete {
  final ProductRepository productRepository;

  ProductUsecaseDelete({required this.productRepository});

  Future<Either<Failure, void>> execute({required String id}) async {
    return await productRepository.deleteProduct(id: id);
  }
}
