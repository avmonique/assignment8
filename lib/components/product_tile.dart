import 'package:ave_assignment8/models/product.dart';
import 'package:ave_assignment8/screens/product_addedit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductListTile extends StatelessWidget {
  ProductListTile({super.key, required this.product, required this.deleteItem, required this.updateItem});

  Product product;
  Function deleteItem;
  final Function(Product) updateItem;

  @override
  Widget build(BuildContext context) {
    var amount_formatter = NumberFormat.currency(
      symbol: 'Php ',
      decimalDigits: 2,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xffE53F71),
        ),
        title: Text(product.name),
        subtitle: Text(amount_formatter.format(double.parse(product.price.toString()))),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (_) => ProductAddEditScreen(operation: updateItem, passedProduct: product),
                  ),
                );
              },
              icon: Icon(Icons.edit,
                color: Colors.amber,
              ),
            ),
            IconButton(
              onPressed: () => deleteItem(product.id, product.name), 
              icon: Icon(Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}