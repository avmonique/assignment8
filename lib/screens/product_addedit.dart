import 'package:ave_assignment8/helpers/db_helper.dart';
import 'package:ave_assignment8/models/product.dart';
import 'package:flutter/material.dart';

class ProductAddEditScreen extends StatefulWidget {
  ProductAddEditScreen({super.key, required this.operation,  this.passedProduct});

  Function(Product p) operation;
  Product? passedProduct;

  @override
  State<ProductAddEditScreen> createState() => _ProductAddEditScreenState();
}

class _ProductAddEditScreenState extends State<ProductAddEditScreen> {
  
  final formKey = GlobalKey<FormState>();
  final product = Product.empty();

  final skuController = TextEditingController();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final discPriceController = TextEditingController();
  final quantityController = TextEditingController();
  final manController = TextEditingController();

  void saveItem() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.passedProduct == null ? 'Add Product' : 'Update Product'),
          content: Text(widget.passedProduct == null
              ? 'Are you sure you want to add this product?'
              : 'Are you sure you want to update this product?'),
          actions: [
            TextButton(
              onPressed: () {
                formKey.currentState!.save();
                widget.operation(product);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }, 
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              child: Text('No'),
            ),
          ],
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    if (widget.passedProduct != null) {
      product.id = widget.passedProduct!.id;
      skuController.text = widget.passedProduct!.sku;
      nameController.text = widget.passedProduct!.name;
      descController.text = widget.passedProduct!.description;
      priceController.text = widget.passedProduct!.price.toString();
      discPriceController.text = widget.passedProduct!.discountedPrice.toString();
      quantityController.text = widget.passedProduct!.quantity.toString();
      manController.text = widget.passedProduct!.manufacturer;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.passedProduct == null ? 'Add Product' : 'Edit Product'),
        actions: [
          IconButton(
            onPressed: saveItem, 
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            TextFormField(
              controller: skuController,
              decoration: const InputDecoration(
                label: Text('SKU'),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                product.sku = newValue!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required field';
                }

                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                label: Text('Name'),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                product.name = newValue!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required field';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: descController,
              decoration: const InputDecoration(
                label: Text('Description'),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              // textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                product.description = newValue!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required field';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(
                label: Text('Price'),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required field';
                }
                var ans = double.tryParse(value);
                if (ans == null) {
                  return 'Enter a valid amount';
                }
                return null;
              },
              onSaved: (newValue) {
                product.price = double.parse(newValue!);
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: discPriceController,
              decoration: const InputDecoration(
                label: Text('Discounted Price'),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required field';
                }
                var ans = double.tryParse(value);
                if (ans == null || ans < 0) {
                  return 'Enter a valid amount';
                }
                return null;
              },
              onSaved: (newValue) {
                product.discountedPrice = double.parse(newValue!);
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: quantityController,
              decoration: const InputDecoration(
                label: Text('Quantity'),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required field';
                }
                var ans = double.tryParse(value);
                if (ans == null || ans <= 0) {
                  return 'Enter a valid amount';
                }
                return null;
              },
              onSaved: (newValue) {
                product.quantity = int.parse(newValue!);
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: manController,
              decoration: const InputDecoration(
                label: Text('Manufacturer'),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              // textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                product.manufacturer = newValue!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required field';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}