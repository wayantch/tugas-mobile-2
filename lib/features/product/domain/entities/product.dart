import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String nameProduct;
  final String price;
  final String description;
  final String? categoryId;
  final String? typeId;
  final String? warehouseId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductEntity({
    required this.id,
    required this.nameProduct,
    required this.price,
    required this.description,
    this.categoryId,
    this.typeId,
    this.warehouseId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    nameProduct,
    price,
    description,
    createdAt,
    updatedAt,
    categoryId,
    typeId,
    warehouseId,
  ];
}
