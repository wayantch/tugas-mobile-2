import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sweetique/features/product/data/models/product_model.dart';
import 'package:sweetique/features/product/domain/entities/product.dart';

class EditProductDialog extends StatefulWidget {
  final ProductEntity product;

  const EditProductDialog({Key? key, required this.product}) : super(key: key);

  @override
  State<EditProductDialog> createState() => _EditProductDialogState();
}

class _EditProductDialogState extends State<EditProductDialog> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.nameProduct);
    priceController = TextEditingController(text: widget.product.price);
    descriptionController = TextEditingController(
      text: widget.product.description ?? '',
    );
  }

  Future<void> editProduct() async {
    if (nameController.text.isEmpty || priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name and Price are required')),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final updatedProduct = ProductModel(
        id: widget.product.id,
        nameProduct: nameController.text.trim(),
        price: priceController.text.trim(),
        description: descriptionController.text.trim(),
        createdAt: widget.product.createdAt,
        updatedAt: DateTime.now(),
      );

      await firestore
          .collection('products')
          .doc(widget.product.id)
          .update(updatedProduct.toFirestore());

      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update product: $e')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Produk'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nama produk'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Harga'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: isLoading ? null : editProduct,
          child:
              isLoading
                  ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : const Text('Simpan'),
        ),
      ],
    );
  }
}
