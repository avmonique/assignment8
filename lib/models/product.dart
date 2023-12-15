import 'package:ave_assignment8/helpers/db_helper.dart';

class Product {
  late int id;
  late String sku;
  late String name;
  late String description;
  late double price;
  late double discountedPrice;
  late int quantity;
  late String manufacturer;

  Product({
    required this.id,
    required this.sku,
    required this.name,
    required this.description,
    required this.price,
    required this.discountedPrice,
    required this.quantity,
    required this.manufacturer,
  });

  Product.empty() {
    id = 0;
    sku = '';
    name = '';
    description = '';
    price = 0;
    discountedPrice = 0;
    quantity = 0;
    manufacturer = '';
  }

  Map<String, dynamic> toMap() {
    return {
      DbHelper.colId: id,
      DbHelper.colSku: sku,
      DbHelper.colName: name,
      DbHelper.colDescription: description,
      DbHelper.colPrice: price,
      DbHelper.coldDiscountedPrice: discountedPrice,
      DbHelper.colQuantity: quantity,
      DbHelper.colManufacturer: manufacturer,
    };
  }

  Map<String, dynamic> toMapWithoudId() {
    return {
      DbHelper.colSku: sku,
      DbHelper.colName: name,
      DbHelper.colDescription: description,
      DbHelper.colPrice: price,
      DbHelper.coldDiscountedPrice: discountedPrice,
      DbHelper.colQuantity: quantity,
      DbHelper.colManufacturer: manufacturer,
    };
  }
}