import 'package:green/src/models/cart_idem_model.dart';

class OrderModel {
  String id;
  DateTime createdDateTime;
  DateTime overdueDateTime;
  List<CartItemModel> items;
  String status;
  String copyAndPaste;
  double total;

  OrderModel ({
  required this.id,
  required this.createdDateTime,
  required this.overdueDateTime,
  required this.items,
  required this.status,
  required this.copyAndPaste,
  required this.total,
  });
}