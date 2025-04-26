import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sweetique/features/product/data/models/product_model.dart';
import 'package:sweetique/features/product/domain/entities/product.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductEntity>> getAllProducts();
  Future<ProductEntity> getProductById({required String id});
  Future<void> addProduct({required ProductModel product});
  Future<void> editProduct({required ProductModel product});
  Future<void> deleteProduct({required String id});
}

class ProductRemoteDataSourceImplementation implements ProductRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  ProductRemoteDataSourceImplementation({required this.firebaseFirestore});

  @override
  Future<void> addProduct({required ProductModel product}) async {
    await firebaseFirestore.collection('products').add(product.toFirestore());
  }

  @override
  Future<void> deleteProduct({required String id}) async {
    await firebaseFirestore.collection('products').doc(id).delete();
  }

  @override
  Future<void> editProduct({required ProductModel product}) async {
    await firebaseFirestore
        .collection('products')
        .doc(product.id)
        .update(product.toFirestore());
  }

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    final data = await firebaseFirestore.collection('products').get();
    return data.docs.map((e) => ProductModel.fromFirestore(e)).toList();
  }

  @override
  Future<ProductEntity> getProductById({required String id}) async {
    final data = await firebaseFirestore.collection('products').doc(id).get();
    return ProductModel.fromFirestore(data);
  }
}
