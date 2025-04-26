import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sweetique/features/product/domain/entities/product.dart';

class ProductModel extends ProductEntity {
  final bool isNew;

  const ProductModel({
    required super.id,
    required super.nameProduct,
    required super.price,
    required super.description,
    super.categoryId,
    super.typeId,
    super.warehouseId,
    super.createdAt,
    super.updatedAt,
    this.isNew = false,
  });

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: doc.id,
      nameProduct: data['nameProduct'],
      price: data['price'],
      description: data['description'],
      categoryId: data['categoryId'] ?? '',
      typeId: data['typeId'] ?? '',
      warehouseId: data['warehouseId'] ?? '',
      createdAt:
          data['createdAt'] != null
              ? (data['createdAt'] as Timestamp).toDate()
              : null,
      updatedAt:
          data['updatedAt'] != null
              ? (data['updatedAt'] as Timestamp).toDate()
              : null,
      isNew: false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'nameProduct': nameProduct,
      'price': price,
      'description': description,
      'categoryId': categoryId ?? '',
      'typeId': typeId ?? '',
      'warehouseId': warehouseId ?? '',
      'createdAt':
          isNew
              ? FieldValue.serverTimestamp()
              : (createdAt != null
                  ? Timestamp.fromDate(createdAt!)
                  : FieldValue.serverTimestamp()),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
