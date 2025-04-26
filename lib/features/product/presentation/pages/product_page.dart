import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetique/core/components/navigation/navigation.dart';
import 'package:sweetique/features/product/domain/entities/product.dart';
import 'package:sweetique/features/product/presentation/bloc/product_bloc.dart';
import 'package:sweetique/features/product/presentation/widgets/add_product_widget.dart';
import 'package:sweetique/features/product/presentation/widgets/edit_product_widget.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // Dummy data for product list
  final List<ProductEntity> dummyProducts = [
    ProductEntity(
      id: '1',
      nameProduct: 'Product 1',
      price: '100.0',
      description: 'This is product 1',
      categoryId: 'cat1',
      typeId: 'type1',
      warehouseId: 'wh1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    ProductEntity(
      id: '2',
      nameProduct: 'Product 2',
      price: '200.0',
      description: 'This is product 2',
      categoryId: 'cat2',
      typeId: 'type2',
      warehouseId: 'wh2',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductGetAllEvent());
  }

  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (context) => const AddProductDialog(),
    ).then((_) {
      // After adding product, refresh list
      context.read<ProductBloc>().add(ProductGetAllEvent());
    });
  }

  void _deleteProduct(String id) {
    // Implement your delete product logic here
    print('Deleting product with id: $id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 3),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoadedAllState) {
            final products =
                state.products.isNotEmpty
                    ? state.products
                    : dummyProducts; // Use dummy data if empty
            if (products.isEmpty) {
              return const Center(child: Text('No products available.'));
            }
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: Text(product.nameProduct),
                  subtitle: Text('Price: \$${product.price}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) =>
                                    EditProductDialog(product: product),
                          ).then((_) {
                            // setelah edit, refresh data
                            context.read<ProductBloc>().add(
                              ProductGetAllEvent(),
                            );
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: const Text('Konfirmasi'),
                                  content: const Text(
                                    'Yakin mau hapus produk ini?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () => Navigator.pop(context), // batal
                                      child: const Text('Batal'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Dispatch event hapus produk
                                        context.read<ProductBloc>().add(
                                          ProductDeleteEvent(
                                            id: product.id,
                                          ), // kirim ID produk
                                        );
                                        Navigator.pop(context); // Tutup dialog
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      child: const Text('Hapus'),
                                    ),
                                  ],
                                ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is ProductErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Unknown state.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProductDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
