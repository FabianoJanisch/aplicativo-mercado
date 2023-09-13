import 'package:green/src/models/item_model.dart';

class CartItemModel {
  int quantity;
  ItemModel item;

  CartItemModel({
    required this.item,
    required this.quantity,
  });

  totalPrice() => item.price * quantity;

}
