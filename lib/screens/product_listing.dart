import 'package:ave_assignment8/components/product_tile.dart';
import 'package:ave_assignment8/helpers/db_helper.dart';
import 'package:ave_assignment8/models/product.dart';
import 'package:ave_assignment8/screens/product_addedit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {

  void insertItem(Product p) {
    DbHelper.insertProduct(p);
    setState(() {
      
    });
  }

  void deleteItem(int id, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text('You are about to delete ${name}.\nAre you sure?'),
          actions: [
            TextButton(
              onPressed: () {
                DbHelper.deleteRaw(id);
                setState(() {});
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
      },
    );
  }

  void updateItem(Product p) {
    DbHelper.updateProduct(p);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Management'),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (_) => ProductAddEditScreen(operation: insertItem),
                ),
              );
            },
            icon: Icon(Icons.add_circle_rounded),
          ),
        ],
      ),
      body: FutureBuilder(
        future: DbHelper.fetchQuery(), 
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('loading data');
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          print('loaded data');
          var products = snapshot.data;
          print(snapshot);
          if (products == null || products.isEmpty) {
            return const Center(
              child: Text('No Product Entries.'),
            );
          }
          return ListView.builder(
            itemBuilder: (_, index) {
              Product product = Product(
                id: products[index][DbHelper.colId], 
                sku: products[index][DbHelper.colSku], 
                name: products[index][DbHelper.colName], 
                description: products[index][DbHelper.colDescription], 
                price: double.parse(products[index][DbHelper.colPrice].toString()),
                discountedPrice: double.parse(products[index][DbHelper.coldDiscountedPrice].toString()),
                quantity: products[index][DbHelper.colQuantity], 
                manufacturer: products[index][DbHelper.colManufacturer], 
              );
              return ProductListTile(
                product: product,
                deleteItem: deleteItem,
                updateItem: updateItem,
              );
            },
            itemCount: products.length,
          );
        },
      ),
    );
  }
}